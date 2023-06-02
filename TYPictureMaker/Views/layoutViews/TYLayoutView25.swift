//
//  TYLayoutView22.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/30.
//

import UIKit

class TYLayoutView25 : TYBaseEditView {
    
    override var padding: CGFloat {
        get {
            return 4
        }
        set {
            
        }
    }
    
    override var imagePandding: CGFloat {
        get {
            return 4
        }
        set {
            
        }
    }
    
    override var imageCornerRadio: CGFloat {
        get {
            return 0
        }
        set {
            
        }
    }
    
    private lazy var mainCollectView : TYImageCollectView = {
        let view = TYImageCollectView(with: images?.first)
        view.tag = 1
        view.padding = 4.0
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
        view.padding = 4.0
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
        let mainViewPoints = [CGPoint(x: 0, y: 0), CGPoint(x: bounds.maxX, y: bounds.minY), CGPoint(x: bounds.minX, y: bounds.maxY)]
        mainCollectView.shape = .custom(mainViewPoints)
        
        let secViewPoints = [CGPoint(x: bounds.maxX, y: bounds.minY), CGPoint(x: bounds.maxX, y: bounds.maxY), CGPoint(x: bounds.minX, y: bounds.maxY)]
        secCollectView.shape = .custom(secViewPoints)
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
