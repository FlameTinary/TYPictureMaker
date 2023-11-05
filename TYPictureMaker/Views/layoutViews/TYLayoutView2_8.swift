//
//  TYLayoutView2_8.swift
//  TYPictureMaker
//
//  Created by server on 2023/11/5.
//

import UIKit

class TYLayoutView28: TYBaseEditView {
    
    override var images: [UIImage]? {
        didSet {
            guard let images = images else { return }
            firstCollectView.image = images.first
            secCollectView.image = images.count > 1 ? images[1] : images.first
        }
    }
    
    private lazy var firstCollectView : TYImageCollectView = {
        let collectView = TYImageCollectView(with: images?.first)
        return collectView
    }()
    
    private lazy var secCollectView : TYImageCollectView = {
        
        var image : UIImage? = images?.first
        if let imgs = images {
            if imgs.count > 1 {
                image = imgs[1]
            }
        }
        
        let collectView = TYImageCollectView(with: image)
        return collectView
    }()
    
    override func setupSubviews() {
        super.setupSubviews()
        addSubview(firstCollectView)
        addSubview(secCollectView)
        
        firstCollectView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(padding)
            make.bottom.equalToSuperview().offset(-padding)
            make.width.equalToSuperview().multipliedBy(0.67)
        }

        secCollectView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(padding)
            make.right.bottom.equalToSuperview().offset(-padding)
            make.width.equalToSuperview().multipliedBy(0.67)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        firstCollectView.shape = .custom(shapePath: leftViewShape())
        secCollectView.shape = .custom(shapePath: rightViewShape())
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if let view = super.hitTest(point, with: event) {
            if !(view is UIScrollView) {
                return view
            } else {
                if firstCollectView.shapeLayer?.path?.contains(point) == true {
                    return firstCollectView.hitTest(point, with: event)
                }

                if secCollectView.shapeLayer?.path?.contains(point) == true {
                    return secCollectView.hitTest(point, with: event)
                }
            }
            
        }
        
        return super.hitTest(point, with: event)
    }
}

extension TYLayoutView28 {
    // 计算左半边视图的半圆
    private func leftViewShape() -> UIBezierPath {
        let startPoint = CGPoint(x: 0, y: 0)
        let secondPoint = CGPoint(x: firstCollectView.bounds.midX, y: 0)
        let thirdPoint = CGPoint(x: firstCollectView.bounds.maxX, y: firstCollectView.bounds.midY + 20)
        let fourthPoint = CGPoint(x: firstCollectView.bounds.midX, y: firstCollectView.bounds.maxY)
        let fifthPoint = CGPoint(x: firstCollectView.bounds.minX, y: firstCollectView.bounds.maxY)
        
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: secondPoint)
        path.addLine(to: thirdPoint)
        path.addLine(to: fourthPoint)
        path.addLine(to: fifthPoint)
        path.close()
        return path
    }
    
    // 计算右半边视图的半圆
    private func rightViewShape() -> UIBezierPath {
        let startPoint = CGPoint(x: firstCollectView.bounds.minX + padding * 3.5, y: secCollectView.bounds.minY)
        let secondPoint = CGPoint(x: secCollectView.bounds.maxX, y: secCollectView.bounds.minY)
        let thirdPoint = CGPoint(x: secCollectView.bounds.maxX, y: secCollectView.bounds.maxY)
        let fourthPoint = CGPoint(x: padding * 3.5, y: secCollectView.bounds.maxY)
        let fifthPoint = CGPoint(x: firstCollectView.bounds.midX + padding * 3.5, y: secCollectView.bounds.midY + 20)
        
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: secondPoint)
        path.addLine(to: thirdPoint)
        path.addLine(to: fourthPoint)
        path.addLine(to: fifthPoint)
        path.close()
        return path
    }
}
