//
//  TYImageScrollView.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/18.
//

import UIKit

class TYImageScrollView : TYBaseView {
    
    var image: UIImage {
        didSet {
            imageView.image = image
        }
    }
    
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
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
