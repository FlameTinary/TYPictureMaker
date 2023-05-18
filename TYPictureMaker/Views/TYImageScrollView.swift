//
//  TYImageScrollView.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/18.
//

import UIKit

class TYImageScrollView : UIScrollView {
    
    var image: UIImage {
        didSet {
            imageView.image = image
        }
    }
    
    private lazy var imageView : UIImageView = {
        let imageView = UIImageView(frame: .zero)
        addSubview(imageView)
        return imageView
    }()
    
    init(with image: UIImage) {
        self.image = image
        super.init(frame: .zero)
//        imageView.image = image
        backgroundColor = .white
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        imageView.frame = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        imageView.frame = bounds
        contentSize = bounds.size
    }
    
    // 双指缩放功能
    
    // 双击显示正常功能
}
