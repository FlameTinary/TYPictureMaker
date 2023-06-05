//
//  TYCombineImagesViewController.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/6/4.
//

import UIKit

class TYCombineImagesViewController: TYOprationEditController {

    // 图片数组
    let images: [UIImage] = [UIImage(named: "image_01")!, UIImage(named: "image_02")!]

    // 创建 UIScrollView
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return scrollView
    }()
    
    
    // 拼接后的图片视图
    let combinedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .top
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        
        
        // 将图片拼接为一张长图
        let combinedImage = combineImagesVertically(images)

        // 显示拼接后的图片
        combinedImageView.image = combinedImage
        combinedImageView.frame = CGRect(x: 0, y: 0, width: view.width, height: 2000)
        scrollView.contentSize = combinedImageView.bounds.size
        scrollView.addSubview(combinedImageView)
        
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




}

