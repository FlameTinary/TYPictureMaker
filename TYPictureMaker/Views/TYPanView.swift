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
    
    private lazy var closeBtn : UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "story_maker_close"), for: .normal)
        btn.backgroundColor = .black
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        _ = btn.rx.tap.takeUntil(self.rx.deallocated).subscribe(onNext: { [weak self] _ in
            self?.removeFromSuperview()
        })
        return btn
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        addSubview(closeBtn)
        closeBtn.snp.makeConstraints { make in
            make.top.equalToSuperview()
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
        var endTouch = beginTouch
        touches.forEach { touch in
            endTouch = touch.location(in: superview)
        }
        
        // 计算当前点击位置和初始点的距离
        let distanceX = endTouch!.x - beginTouch!.x
        let distanceY = endTouch!.y - beginTouch!.y
        let size = self.frame.size
        self.frame = CGRect(origin: CGPoint(x: distanceX, y: distanceY), size: size)
    }
}
