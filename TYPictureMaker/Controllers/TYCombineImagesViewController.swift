//
//  TYCombineImagesViewController.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/6/4.
//

import UIKit
//import ZLPhotoBrowser
import RxSwift
import RxCocoa

class TYCombineImagesViewController: TYBaseViewController {

//MARK: 属性定义
    // 传入的原始图片数组
    var originalImages : [UIImage]
    
    // 拼接后的图片
    private var combinedImage: UIImage?

    // 创建 UIScrollView
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return scrollView
    }()
    
    // 拼接后的图片视图
    private lazy var combinedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var barButtonItem : UIBarButtonItem = {
        
        // 创建一个按钮
        let saveButton = UIButton(type: .custom)
        saveButton.frame = CGRect(x: 0, y: 0, width: 60, height: 30)
        saveButton.setTitle("保存", for: .normal)
        saveButton.titleLabel?.font = normalFont
        saveButton.setTitleColor(normalTextColor, for: .normal)
        saveButton.backgroundColor = UIColor(hexString: "#1296db")
        saveButton.layer.cornerRadius = 4.0
        _ = saveButton.rx.tap.takeUntil(rx.deallocated).subscribe { [weak self] _ in

            guard let self = self, let image = self.combinedImage else {return}
            // 保存图片到相册
            self.photoSave(image: image)
        }
        
        // 创建一个自定义视图
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
        customView.backgroundColor = selectColor
        customView.layer.cornerRadius = 4
        customView.addSubview(saveButton)

        // 创建一个UIBarButtonItem，并将自定义视图设置为customView
        let barButtonItem = UIBarButtonItem(customView: customView)
        return barButtonItem
        
    }()
    
    //MARK: 初始化方法
    init(originalImages: [UIImage]) {
        self.originalImages = originalImages
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        // 设置导航栏右侧按钮
        navigationItem.rightBarButtonItem = barButtonItem
        view.addSubview(scrollView)
        
        if let image = self.combineImagesVertically(self.originalImages) {
            // 计算图片宽高
            let imageRadio = image.size.width / image.size.height
            let imageViewW = self.view.width
            let imageViewH = imageViewW / imageRadio
            
            // 显示拼接后的图片
            self.combinedImageView.image = image
            self.combinedImageView.frame = CGRect(x: 0, y: 0, width: imageViewW, height: imageViewH)
            self.scrollView.contentSize = self.combinedImageView.bounds.size
            self.scrollView.addSubview(self.combinedImageView)
            
            self.combinedImage = image
        }
    }
    
//MARK: 图片拼接方法
    private func combineImagesVertically(_ images: [UIImage]) -> UIImage? {
        guard !images.isEmpty else { return nil }

        // 计算拼接后的图片的总高度和最小宽度
        let totalHeight = images.reduce(0) { $0 + $1.size.height }
        let minWidth = images.reduce(CGFloat.greatestFiniteMagnitude) { min($0, $1.size.width) }

        // 创建绘制上下文
        UIGraphicsBeginImageContextWithOptions(CGSize(width: minWidth, height: totalHeight), false, 0.0)
        defer { UIGraphicsEndImageContext() }

        // 绘制每张图片到上下文中
        var offsetY: CGFloat = 0
        for image in images {
            let offsetX = (minWidth - image.size.width) / 2 // 计算水平居中的偏移量
            let rect = CGRect(x: offsetX, y: offsetY, width: image.size.width, height: image.size.height)
            image.draw(in: rect)
            offsetY += image.size.height
        }

        // 获取拼接后的图片
        let combinedImage = UIGraphicsGetImageFromCurrentImageContext()
        return combinedImage
    }
}

