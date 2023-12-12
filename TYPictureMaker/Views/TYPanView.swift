//
//  TYPanView.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/26.
//  可拖动的视图

import UIKit
import RxSwift
import RxCocoa

class TYPanView : UIView {
    
    private var beginTouch : CGPoint?
    private var endTouch : CGPoint?
    private var rotationPoint: CGPoint = CGPoint(x: 0, y: 0)
    private var startAngle: CGFloat = 0
    private var currentCenter : CGPoint?
    
    private lazy var borderView : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.clear.cgColor
        view.layer.borderWidth = 0.5
        addSubview(view)
        return view
    }()
    
    // 关闭按钮
    private lazy var closeBtn : UIButton = {
        let textStyle = UIImage.SymbolConfiguration(textStyle: .subheadline)
        let black = UIImage.SymbolConfiguration(weight: .ultraLight)
        let combined = textStyle.applying(black)
        let btn = UIButton(type: .custom)
        btn.tag = 0
        btn.setImage(UIImage(systemName: "xmark.circle",withConfiguration: combined), for: .normal)
        btn.tintColor = .white
        btn.backgroundColor = .clear
        btn.alpha = 0.0
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        _ = btn.rx.tap.takeUntil(self.rx.deallocated).subscribe(onNext: { [weak self] _ in
            self?.removeFromSuperview()
        })
        addSubview(btn)
        return btn
    }()
    
    // 旋转按钮
    private lazy var rotationBtn : UIButton = {
        
        let textStyle = UIImage.SymbolConfiguration(textStyle: .subheadline)
        let black = UIImage.SymbolConfiguration(weight: .ultraLight)
        let combined = textStyle.applying(black)
        
        let btn = UIButton(type: .custom)
        btn.tag = 1
        btn.setImage(UIImage(systemName: "arrow.clockwise.circle", withConfiguration: combined), for: .normal)
        btn.tintColor = .white
        btn.backgroundColor = .clear
        btn.alpha = 0.0
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(buttonDragged(_:event:)), for: .touchDragInside)
        btn.addTarget(self, action: #selector(buttonDown(_:event:)), for: .touchDown)
        addSubview(btn)
        return btn
    }()
    
    // 修改大小按钮
    private lazy var resizeBtn : UIButton = {
        let textStyle = UIImage.SymbolConfiguration(textStyle: .subheadline)
        let black = UIImage.SymbolConfiguration(weight: .ultraLight)
        let combined = textStyle.applying(black)
        let btn = UIButton(type: .custom)
        btn.tag = 2
        btn.setImage(UIImage(systemName: "arrow.down.forward.and.arrow.up.backward.circle",withConfiguration: combined), for: .normal)
        btn.tintColor = .white
        btn.backgroundColor = .clear
        btn.alpha = 0.0
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(buttonDragged(_:event:)), for: .touchDragInside)
//        btn.addTarget(self, action: #selector(buttonDown(_:event:)), for: .touchDown)
        addSubview(btn)
        return btn
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(pinchAction(_:)))
        addGestureRecognizer(pinch)
        
        borderView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        closeBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-10)
            make.right.equalToSuperview().offset(10)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        
        rotationBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(10)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        
        resizeBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(-10)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 手势响应方法
    @objc func pinchAction(_ pinch: UIPinchGestureRecognizer) {
        let scale = pinch.scale
        // 放大/缩小 view
        pinch.view?.transform = (pinch.view?.transform.scaledBy(x: scale, y: scale))!
        // 重置比例
        pinch.scale = 1
    }

    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("frame: \(self.frame)")
//        guard let superview = superview else { return }
//        
//        // 获取旋转后的视图边界框
//        let rotatedBounds = self.bounds.applying(self.transform)
//
//        // 获取旋转后的视图中心点
//        let rotatedCenter = CGPoint(x: self.center.x + self.transform.tx, y: self.center.y + self.transform.ty)
//        
//        // 获取旋转后的视图位置和大小
//        let rotatedFrame = CGRect(x: rotatedCenter.x - rotatedBounds.width / 2.0,
//                                  y: rotatedCenter.y - rotatedBounds.height / 2.0,
//                                  width: rotatedBounds.width,
//                                  height: rotatedBounds.height)
//        
//        // 在父视图的右边
//        if rotatedFrame.maxX > superview.frame.maxX {
//            self.left = superview.frame.maxX - self.width
//        }
//        // 在父视图的左边
//        if rotatedFrame.minX < 0 {
//            self.left = superview.frame.minX
//        }
//        // 在父视图的上边
//        if rotatedFrame.minY < 0 {
//            self.top = 0
//        }
//        
//        // 在父视图的下边
//        if rotatedFrame.maxY > superview.frame.maxY - self.height {
//            self.top = superview.frame.maxY - self.height - self.height
//        }
//    }
    
    @objc private func buttonDown(_ sender: UIButton, event: UIEvent) {
        guard let touch = event.touches(for: sender)?.first else { return }
        let startPoint = touch.location(in: self)
        startAngle = angleFromPoint(startPoint)
    }
    
    @objc private func buttonDragged(_ sender: UIButton, event: UIEvent) {
        guard let touch = event.touches(for: sender)?.first else { return }
        let currentPoint = touch.location(in: self)
        if sender.tag == 1 {
            let currentAngle = angleFromPoint(currentPoint)
            let angleDiff = currentAngle - startAngle
            self.transform = self.transform.rotated(by: angleDiff)
        } else if sender.tag == 2 {
            let previousLocation = touch.previousLocation(in: self)
            let delta = CGPoint(x: currentPoint.x - previousLocation.x, y: currentPoint.y - previousLocation.y)

            // 改变视图的大小
            let newWidth = maxX - delta.x
            let newHeight = maxY - delta.y
            self.snp.remakeConstraints { make in
                make.center.equalTo(currentCenter!)
                make.size.equalTo(CGSize(width: newWidth < 20 ? 20 : newWidth, height: newHeight < 20 ? 20 : newHeight))
            }
        }
    }
    
    // 计算角度
    private func angleFromPoint(_ point: CGPoint) -> CGFloat {
        let dx = point.x - rotationPoint.x
        let dy = point.y - rotationPoint.y
        return atan2(dy, dx)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        let buttonPoint = closeBtn.convert(point, from: self)
        if closeBtn.point(inside: buttonPoint, with: event) {
            return closeBtn
        }
        let rotationPoint = rotationBtn.convert(point, from: self)
        if rotationBtn.point(inside: rotationPoint, with: event) {
            return rotationBtn
        }
        let resizePoint = resizeBtn.convert(point, from: self)
        if resizeBtn.point(inside: resizePoint, with: event) {
            return resizeBtn
        }
        hitAnimation(point: point)
        return super.hitTest(point, with: event)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        print("当前的frame：\(frame)")
        if currentCenter == nil {
            currentCenter = center
        }
    }
}


//MARK: touches方法
extension TYPanView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 获取当前点击位置
        touches.forEach { touch in
            beginTouch = touch.location(in: self)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 获取当前点击位置
        touches.forEach { touch in
            endTouch = touch.location(in: self)
            
        }
        
        let distanceX = endTouch!.x - beginTouch!.x
        let distanceY = endTouch!.y - beginTouch!.y

        self.transform = self.transform.translatedBy(x: distanceX, y: distanceY)
        currentCenter = center
    }
}

//MARK: 响应焦点动画
private extension TYPanView {
    // 判断点击是否在当前视图上，如果在当前视图，则显示各种操作按钮，如果不在则隐藏各种操作按钮
    // 动画时常
    var animationTime : Double {
        get {
            return 0.25
        }
    }
    func hitAnimation(point: CGPoint) {
        if point.x > maxX || point.x < minX || point.y > maxY || point.y < minY { // 不在点击范围内
            UIView.animate(withDuration: animationTime) {
                self.backgroundColor = .clear
                self.closeBtn.alpha = 0.0
                self.rotationBtn.alpha = 0.0
                self.resizeBtn.alpha = 0.0
                self.borderView.layer.borderColor = UIColor.clear.cgColor
            }
        } else { // 在点击范围内
            UIView.animate(withDuration: animationTime) {
                self.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.1)
                self.closeBtn.alpha = 1.0
                self.rotationBtn.alpha = 1.0
                self.resizeBtn.alpha = 1.0
                self.borderView.layer.borderColor = UIColor.lightGray.cgColor
            }
        }
    }
}
