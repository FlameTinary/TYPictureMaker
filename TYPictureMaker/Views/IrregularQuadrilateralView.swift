//
//  File.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/29.
//

import UIKit

class IrregularQuadrilateralView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 创建一个不规则的四边形路径
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.minX, y: bounds.minY))
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.minY))
        path.addLine(to: CGPoint(x: bounds.maxX - 50, y: bounds.maxY))
        path.addLine(to: CGPoint(x: bounds.minX + 50, y: bounds.maxY))
        path.close()
        
        // 创建一个形状图层，并设置路径
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        
        // 设置视图的遮罩为形状图层
        layer.mask = shapeLayer
    }
}

