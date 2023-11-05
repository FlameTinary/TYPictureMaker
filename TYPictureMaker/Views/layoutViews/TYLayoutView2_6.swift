//
//  TYLayoutView2_6.swift
//  TYPictureMaker
//
//  Created by server on 2023/11/4.
//

import UIKit

class TYLayoutView26: TYBaseEditView {
    
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
        backgroundColor = UIColor.red
        addSubview(firstCollectView)
        addSubview(secCollectView)
        
        firstCollectView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(padding)
            make.bottom.equalToSuperview().offset(-padding)
            make.width.equalTo(secCollectView)
        }

        secCollectView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(padding)
            make.right.bottom.equalToSuperview().offset(-padding)
            make.left.equalTo(firstCollectView.snp.right).offset(padding)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("countent:\(contentView.frame)")
        print("firstCollectView:\(firstCollectView.frame)")
        firstCollectView.shape = .custom(shapePath: leftViewShape())
        secCollectView.shape = .custom(shapePath: rightViewShape())
    }
}

extension TYLayoutView26 {
    // 计算左半边视图的半圆
    private func leftViewShape() -> UIBezierPath {
        // 如果长边不足短边的一倍的话，那么半径为原半径的一半
        var radius = min(firstCollectView.width, firstCollectView.height)
        if max(firstCollectView.width,firstCollectView.height) < min(firstCollectView.width,firstCollectView.height) * 2 {
            radius = radius / 2
        }
        let startPoint = CGPoint(x: firstCollectView.bounds.minX, y: firstCollectView.height / 2.0 - radius)
        let center = CGPoint(x: firstCollectView.bounds.minX, y: firstCollectView.height / 2.0)
        
        let startAngle : CGFloat = .pi * 3 / 2
        let endAngle : CGFloat = .pi / 2
        let clockwise = true
        
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        path.addLine(to: startPoint)
        return path
    }
    
    // 计算右半边视图的半圆
    private func rightViewShape() -> UIBezierPath {
        // 如果长边不足短边的一倍的话，那么半径为原半径的一半
        var radius = min(secCollectView.width, secCollectView.height)
        if max(secCollectView.width,secCollectView.height) < min(secCollectView.width,secCollectView.height) * 2 {
            radius = radius / 2
        }
        let startPoint = CGPoint(x: secCollectView.bounds.maxX, y: secCollectView.height / 2.0 - radius)
        let center = CGPoint(x: secCollectView.bounds.maxX, y: secCollectView.height / 2.0)
        
        let startAngle : CGFloat = .pi * 3 / 2
        let endAngle : CGFloat = .pi / 2
        let clockwise = false
        
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        path.addLine(to: startPoint)
        return path
    }
}
