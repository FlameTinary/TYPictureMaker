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
    
    // 关闭按钮
    private lazy var closeBtn : UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "story_maker_close"), for: .normal)
        btn.backgroundColor = .black
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
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "rotation"), for: .normal)
        btn.backgroundColor = .black
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(buttonDragged(_:event:)), for: .touchDragInside)
        btn.addTarget(self, action: #selector(buttonDown(_:event:)), for: .touchDown)
        addSubview(btn)
        return btn
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        closeBtn.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        
        rotationBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        let currentAngle = angleFromPoint(currentPoint)
        let angleDiff = currentAngle - startAngle
        self.transform = self.transform.rotated(by: angleDiff)
    }
    
    // 计算角度
    private func angleFromPoint(_ point: CGPoint) -> CGFloat {
        let dx = point.x - rotationPoint.x
        let dy = point.y - rotationPoint.y
        return atan2(dy, dx)
    }
}
