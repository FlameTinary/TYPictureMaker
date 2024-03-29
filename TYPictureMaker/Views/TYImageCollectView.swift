//
//  TYImageCollectView.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/18.
//  图片收集视图

import UIKit
//import ZLPhotoBrowser
//
import RxSwift
import RxCocoa

class TYImageCollectView : TYBaseView {
    
//    weak var sender : UIViewController?
    var shape : TYShapes = .none {
        didSet {
            imageScrollView.shape = shape
        }
    }
    
    var shapeLayer : CAShapeLayer?
    
    var image: UIImage? {
        didSet {
            guard let img = image else { return }
//            backImageView.isHidden = true
//            imageScrollView.isHidden = false
            imageScrollView.image = img
        }
    }
    
//    private lazy var backImageView : UIImageView = {
//        let imageView = UIImageView()
//        imageView.isUserInteractionEnabled = true
//        let gesture = UITapGestureRecognizer()
//        imageView.addGestureRecognizer(gesture)
//        _ = gesture.rx.event.takeUntil(self.rx.deallocated).bind(onNext: {gesture in
//            if let sender = self.parentViewController {
//                // 打开相册
//                sender.pickImages { images, asset, isOriginal in
//                    self.image = images.first
//                }
//            }
//        })
//        return imageView
//    }()
    
    var padding : CGFloat = 0 {
        didSet {
            updateSubViews()
        }
    }
    
    var cornerRaido : CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRaido
            layer.masksToBounds = true
            imageScrollView.cornerRadio = cornerRaido
        }
    }
    
    private lazy var imageScrollView : TYImageScrollView = {
        let scrollView = TYImageScrollView()
        scrollView.shape = shape
        return scrollView
    }()
    
    override init() {
        super.init()
        backgroundColor = .cyan
    }
    
    convenience init(with image: UIImage?, shape: TYShapes = .none, padding: CGFloat = 0) {
        self.init()
        self.image = image
        self.shape = shape
        self.padding = padding
//            backImageView.isHidden = true
//        imageScrollView.isHidden = false
        imageScrollView.image = image
        imageScrollView.shape = shape
        
        backgroundColor = .white
        updateSubViews()
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
//        addSubview(backImageView)
        addSubview(imageScrollView)
        
//        imageScrollView.isHidden = image == nil
        
//        backImageView.snp.makeConstraints { make in
//            make.edges.equalToSuperview().inset(UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
//        }
        
        imageScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
        }
        
    }
    
    func updateSubViews() {
        
//        backImageView.snp.remakeConstraints { make in
//            make.edges.equalToSuperview().inset(UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
//        }
        imageScrollView.snp.remakeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        switch shape {
        case .none:
            return
        case .rectangle:
            return
        case .circle:
            // 创建一个圆形路径
            let radius = min(bounds.width, bounds.height) / 2
            let center = CGPoint(x: bounds.midX, y: bounds.midY)
            let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
            
            // 创建一个形状图层，并设置路径
            shapeLayer = CAShapeLayer()
            shapeLayer!.path = path.cgPath
            
            // 设置视图的遮罩为形状图层
            layer.mask = shapeLayer
        case let .custom(points):
            // 创建一个不规则的四边形路径
            let path = UIBezierPath()
            for (index, point) in points.enumerated() {
                if index == 0 {
                    path.move(to: point)
                } else {
                    path.addLine(to: point)
                }
            }
            path.close()
            
            // 创建一个形状图层，并设置路径
            shapeLayer = CAShapeLayer()
            shapeLayer!.path = path.cgPath
            
            // 设置视图的遮罩为形状图层
            layer.mask = shapeLayer

        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension TYImageCollectView {
    
}
