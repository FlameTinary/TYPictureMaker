//
//  TYImageScrollView.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/18.
//

import UIKit
import RxSwift
import RxCocoa

class TYImageScrollView : TYBaseView {
    
    var shape : TYShapes = .none
    
    private var shapeLayer : CAShapeLayer?
    
    // 源图
    var image: UIImage? {
        didSet {
            imageView.image = image
//            filterImage = image
        }
    }
    
//    // 滤镜图
//    var filterImage : UIImage?
    
    var cornerRadio : CGFloat = 0 {
        didSet {
            scrollView.layer.cornerRadius = cornerRadio
            scrollView.layer.masksToBounds = true
        }
    }
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView(frame: bounds)
        sv.showsHorizontalScrollIndicator = false
        sv.showsVerticalScrollIndicator = false
        sv.backgroundColor = .clear
        sv.delegate = self
        sv.minimumZoomScale = 1
        sv.maximumZoomScale = 2
        addSubview(sv)
        return sv
    }()
    
    private lazy var imageView : UIImageView = {
        let imageView = UIImageView(frame: .zero)
        scrollView.addSubview(imageView)
        return imageView
    }()
    
    override init() {
        super.init()
        backgroundColor = .clear
//        setupNotification()
    }
    
    convenience init(with image: UIImage?) {
        self.init()
        if let img = image {
            self.image = img
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    private func setupNotification() {
//
//        let changeFilterNotification = Notification.Name("changeFilter")
//        let filterIntensityNotification = Notification.Name("changeIntensity")
//
//        _ = NotificationCenter.default.rx.notification(changeFilterNotification).takeUntil(self.rx.deallocated).subscribe { [weak self] notification in
//            guard let obj = notification.object else {return}
//            let filterName = obj as! TYFilterEnum
//            if filterName == .none {
//                self?.imageView.image = self?.image
//                self?.filter = nil
//            } else {
//                self?.filter = CIFilter(name: filterName.toCIFilterName())
//                let ciImage = CIImage(image: (self?.filterImage)!)
//                self?.filter?.setValue(ciImage, forKey: kCIInputImageKey)
//            }
//        }
//
//        _ = NotificationCenter.default.rx.notification(filterIntensityNotification).takeUntil(self.rx.deallocated).subscribe { [weak self] notification in
//            guard let obj = notification.object else {return}
//            print(obj)
//            if nil != self?.filter {
//                self?.applyOldPhotoFilter(intensity: obj as! Float)
//            }
//
//        }
//    }
    
    // 通过图片的size得到视图的size
    func getImageViewSizeWith(image:UIImage) -> CGSize {
        var scrollW = bounds.size.width + 1
        var scrollH = scrollW / image.size.width * image.size.height
        if (scrollH < bounds.size.height) {
            scrollH = bounds.size.height + 1
            scrollW = scrollH / image.size.height * image.size.width
        }
        return CGSize(width: scrollW, height: scrollH)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let img = image {
            scrollView.frame = bounds
            scrollView.contentSize = getImageViewSizeWith(image: img)
            imageView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: scrollView.contentSize)
        }
        
        switch shape {
        case .none:
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
    
    // 双指缩放功能
    
    // 双击显示正常功能
}

extension TYImageScrollView: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}


