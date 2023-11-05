//
//  TYLayoutView22.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/30.
//

import UIKit

class TYLayoutView25 : TYBaseEditView {
    
    override var images: [UIImage]? {
        didSet {
            guard let images = images else { return }
            mainCollectView.image = images.first
            secCollectView.image = images.count > 1 ? images[1] : images.first
        }
    }
    
//    override var padding: CGFloat {
//        get {
//            return 6
//        }
//        set {
//
//        }
//    }
//
//    override var imagePandding: CGFloat {
//        get {
//            return 0
//        }
//        set {
//
//        }
//    }
//
//    override var imageCornerRadio: CGFloat {
//        get {
//            return 0
//        }
//        set {
//
//        }
//    }
    
    private lazy var mainCollectView : TYImageCollectView = {
        let view = TYImageCollectView(with: images?.first)
        view.tag = 1
//        view.padding = 4.0
        return view
    }()
    
    private lazy var secCollectView : TYImageCollectView = {
        var image : UIImage? = images?.first
        if let imgs = images {
            if imgs.count > 1 {
                image = imgs[1]
            }
        }
        
        
        let view = TYImageCollectView(with: image)
        view.tag = 2
//        view.padding = 4.0
//        view.isUserInteractionEnabled = false
        return view
    }()
    
    override func setupSubviews() {
        super.setupSubviews()
        
        contentView.addSubview(mainCollectView)
        contentView.addSubview(secCollectView)
        
        mainCollectView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        secCollectView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        let mainViewBorderPath = UIBezierPath()
//        mainViewBorderPath.move(to: CGPoint(x: 1, y: 1))
//        mainViewBorderPath.addLine(to: CGPoint(x: contentView.bounds.maxX - (padding / 2) - 1, y: contentView.bounds.minY + 1))
//        mainViewBorderPath.addLine(to: CGPoint(x: contentView.bounds.minX - 1, y: contentView.bounds.maxY - (padding / 2) + 1))
//        mainViewBorderPath.addLine(to: CGPoint(x: 1, y: 1))
//        mainViewBorderPath.close()
        
        let mainViewShapePath = UIBezierPath()
        mainViewShapePath.move(to: CGPoint(x: 0, y: 0))
        mainViewShapePath.addLine(to: CGPoint(x: contentView.bounds.maxX - (padding / 2), y: contentView.bounds.minY))
        mainViewShapePath.addLine(to: CGPoint(x: contentView.bounds.minX, y: contentView.bounds.maxY - (padding / 2)))
//        mainViewShapePath.addLine(to: CGPoint(x: 1, y: 1))
        mainViewShapePath.close()
        mainCollectView.shape = .custom(shapePath: mainViewShapePath)
        
        // 设置遮罩路径
//        let mainViewPoints = [CGPoint(x: 0, y: 0), CGPoint(x: contentView.bounds.maxX - (padding / 2), y: contentView.bounds.minY), CGPoint(x: contentView.bounds.minX, y: contentView.bounds.maxY - (padding / 2))]
//        mainCollectView.shape = .custom(mainViewPoints)
        
//        let secViewBorderPath = UIBezierPath()
//        secViewBorderPath.move(to: CGPoint(x: contentView.bounds.maxX - 1, y: contentView.bounds.minY + (padding / 2) + 1))
//        secViewBorderPath.addLine(to: CGPoint(x: contentView.bounds.maxX - 1, y: contentView.bounds.maxY - 1))
//        secViewBorderPath.addLine(to: CGPoint(x: contentView.bounds.minX + 1, y: contentView.bounds.maxY - (padding / 2) - 1))
////        secViewBorderPath.addLine(to: CGPoint(x: 1, y: 1))
//        secViewBorderPath.close()
        
        let secViewShapePath = UIBezierPath()
        secViewShapePath.move(to: CGPoint(x: contentView.bounds.maxX, y: contentView.bounds.minY + (padding / 2)))
        secViewShapePath.addLine(to: CGPoint(x: contentView.bounds.maxX, y: contentView.bounds.maxY))
        secViewShapePath.addLine(to: CGPoint(x: contentView.bounds.minX + (padding / 2), y: contentView.bounds.maxY))
//        secViewShapePath.addLine(to: CGPoint(x: 1, y: 1))
        secViewShapePath.close()
        secCollectView.shape = .custom(shapePath: secViewShapePath)
        
//        let secViewPoints = [CGPoint(x: contentView.bounds.maxX, y: contentView.bounds.minY + (padding / 2)), CGPoint(x: contentView.bounds.maxX, y: contentView.bounds.maxY), CGPoint(x: contentView.bounds.minX + (padding / 2), y: contentView.bounds.maxY)]
//        secCollectView.shape = .custom(secViewPoints)
        
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if let view = super.hitTest(point, with: event) {
            if !(view is UIScrollView) {
                return view
            } else {
                if mainCollectView.shapeLayer?.path?.contains(point) == true {
                    return mainCollectView.hitTest(point, with: event)
                }

                if secCollectView.shapeLayer?.path?.contains(point) == true {
                    return secCollectView.hitTest(point, with: event)
                }
            }
            
        }
        
        return super.hitTest(point, with: event)
    }
}
