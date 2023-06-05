//
//  TYCombineImagesViewController.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/6/4.
//

import UIKit
import ZLPhotoBrowser
import RxSwift
import RxCocoa

class TYCombineImagesViewController: TYBaseViewController {

    // 图片数组
    private var image: UIImage?

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

            guard let self = self, let image = self.image else {return}
            // 保存图片到相册
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.imageSaved(_:didFinishSavingWithError:contextInfo:)), nil)

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
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置导航栏右侧按钮
        navigationItem.rightBarButtonItem = barButtonItem
        view.addSubview(scrollView)
        
        // 打开相册
        let ps = ZLPhotoPreviewSheet()
        ps.selectImageBlock = { [weak self] results, isOriginal in
            
            // 将图片拼接为一张长图
            guard let self = self, let combinedImage = self.combineImagesVertically(results.map{$0.image}) else { return }
            self.image = combinedImage
            // 计算图片宽高
            let imageRadio = combinedImage.size.width / combinedImage.size.height
            let imageViewW = self.view.width
            let imageViewH = imageViewW / imageRadio
            
            // 显示拼接后的图片
            self.combinedImageView.image = combinedImage
            self.combinedImageView.frame = CGRect(x: 0, y: 0, width: imageViewW, height: imageViewH)
            self.scrollView.contentSize = self.combinedImageView.bounds.size
            self.scrollView.addSubview(self.combinedImageView)
        }
        ps.showPhotoLibrary(sender: self)
        
        

        
        
    }
    
    func combineImagesVertically(_ images: [UIImage]) -> UIImage? {
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

    @objc func imageSaved(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // 图片保存失败
            view.makeToast("保存图片到相册失败: \(error.localizedDescription)", duration: 1.0, position: .center)
        } else {
            // 图片保存成功
            view.makeToast("图片保存成功", duration: 1.0, position: .center)
        }
    }


}

