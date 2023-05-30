//
//  File.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/29.
//

import UIKit

class IrregularQuadrilateralView: UIView {
    
    private var shapeLayer: CAShapeLayer!
        private var tapGesture: UITapGestureRecognizer!
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            setup()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            
            setup()
        }
        
        private func setup() {
            // 创建一个不规则的四边形路径
            let path = UIBezierPath()
            path.move(to: CGPoint(x: bounds.minX, y: bounds.minY))
            path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.minY))
            path.addLine(to: CGPoint(x: bounds.maxX - 50, y: bounds.maxY))
            path.addLine(to: CGPoint(x: bounds.minX + 50, y: bounds.maxY))
            path.close()
            // 裁剪路径，只显示路径内部的区域
            shapeLayer = CAShapeLayer()
            shapeLayer.path = path.cgPath
            layer.mask = shapeLayer
            
            // 添加手势识别器
            tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            addGestureRecognizer(tapGesture)
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            // 更新裁剪路径，确保它与视图的边界一致
            let path = UIBezierPath()
            path.move(to: CGPoint(x: bounds.minX, y: bounds.minY))
            path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.minY))
            path.addLine(to: CGPoint(x: bounds.maxX - 50, y: bounds.maxY))
            path.addLine(to: CGPoint(x: bounds.minX + 50, y: bounds.maxY))
            path.close()
            shapeLayer.path = path.cgPath
        }
        
        @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
            // 响应点击事件的处理逻辑
            print("View tapped!")
        }
}

