//
//  File.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/29.
//

import UIKit

class CircularView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 创建一个圆形路径
        let radius = min(bounds.width, bounds.height) / 2
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        
        // 创建一个形状图层，并设置路径
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        
        // 设置视图的遮罩为形状图层
        layer.mask = shapeLayer
    }
}

