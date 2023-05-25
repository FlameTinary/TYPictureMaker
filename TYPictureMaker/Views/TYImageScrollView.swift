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
    
    // filter
    private let context = CIContext(options: nil)
    private var filter : CIFilter?
    private var orientation = UIImage.Orientation.up
    
    // 源图
    var image: UIImage {
        didSet {
            imageView.image = image
            filterImage = image
        }
    }
    
    // 滤镜图
    var filterImage : UIImage?
    
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
    
    init(with image: UIImage) {
        self.image = image
        super.init()
        backgroundColor = .clear
        setupNotification()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupNotification() {
        
        let changeFilterNotification = Notification.Name("changeFilter")
        let filterIntensityNotification = Notification.Name("changeIntensity")
        
        _ = NotificationCenter.default.rx.notification(changeFilterNotification).takeUntil(self.rx.deallocated).subscribe { [weak self] notification in
            guard let obj = notification.object else {return}
            let filterName = obj as! TYFilterEnum
            if filterName == .none {
                self?.imageView.image = self?.image
            } else {
                self?.filter = CIFilter(name: filterName.toCIFilterName())
                let ciImage = CIImage(image: (self?.filterImage)!)
                self?.filter?.setValue(ciImage, forKey: kCIInputImageKey)
            }
        }
        
        _ = NotificationCenter.default.rx.notification(filterIntensityNotification).takeUntil(self.rx.deallocated).subscribe { [weak self] notification in
            guard let obj = notification.object else {return}
            print(obj)
            if nil != self?.filter {
                self?.applyOldPhotoFilter(intensity: obj as! Float)
            }
            
        }
    }
    
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
        scrollView.frame = bounds
        scrollView.contentSize = getImageViewSizeWith(image: image)
        imageView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: scrollView.contentSize)
    }
    
    // 双指缩放功能
    
    // 双击显示正常功能
}

extension TYImageScrollView: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}

extension TYImageScrollView {
    
    func applySepiaFilter(intensity: Float) {
        guard let f = filter else { return }
        if (f.name == "none") {return}
        
        f.setValue(intensity, forKey: kCIInputIntensityKey)

        guard let outputImage = f.outputImage else { return }

        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        imageView.image = UIImage(cgImage: cgImage, scale: 1, orientation: orientation)
    }
    
    func applyOldPhotoFilter(intensity: Float) {
        guard let f = filter else { return }
        
        if (f.name == "none") {return}
            
        f.setValue(intensity, forKey: kCIInputIntensityKey)

        let random = CIFilter(name: "CIRandomGenerator")

        let lighten = CIFilter(name: "CIColorControls")
        lighten?.setValue(random?.outputImage, forKey: kCIInputImageKey)
        lighten?.setValue(1 - intensity, forKey: kCIInputBrightnessKey)
        lighten?.setValue(0, forKey: kCIInputSaturationKey)

        guard let ciImage = f.value(forKey: kCIInputImageKey) as? CIImage else { return }
        let croppedImage = lighten?.outputImage?.cropped(to: ciImage.extent)

        let composite = CIFilter(name: "CIHardLightBlendMode")
        composite?.setValue(f.outputImage, forKey: kCIInputImageKey)
        composite?.setValue(croppedImage, forKey: kCIInputBackgroundImageKey)

        let vignette = CIFilter(name: "CIVignette")
        vignette?.setValue(composite?.outputImage, forKey: kCIInputImageKey)
        vignette?.setValue(intensity * 2, forKey: kCIInputIntensityKey)
        vignette?.setValue(intensity * 30, forKey: kCIInputRadiusKey)

        guard let outputImage = vignette?.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        imageView.image = UIImage(cgImage: cgImage, scale: 1, orientation: orientation)
    }
}
