//
//  TYUpdownView.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/17.
//  简易布局

import UIKit
import SnapKit

class TYNormalLayoutView: TYBaseView {
    
    // 边框图片
    var frameImage : UIImage? {
        didSet {
            frameImageView.image = frameImage
        }
    }
    
    // 图片集
    var images : [UIImage]
    
    // 布局方向
    var axis : TYLayoutEditEnum = .vertical
    
    private lazy var contentView : UIView = {
        let view = UIView()
        return view
    }()
    
//    private lazy var stackView : UIStackView = {
//        let imageViews : [TYImageCollectView] = images.map { image in TYImageCollectView(with: image)}
//        let stackView = UIStackView(arrangedSubviews: imageViews)
//        stackView.axis = axis
//        stackView.alignment = .fill
//        stackView.distribution = .fillEqually
//        addSubview(stackView)
//        return stackView
//    }()
    
    private lazy var frameImageView : UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    // 边框间距
    var pandding : CGFloat = 0 {
        didSet {
            contentView.snp.remakeConstraints { make in
                make.edges.equalToSuperview().inset(UIEdgeInsets(top: pandding, left: pandding, bottom: pandding, right: pandding))
            }
        }
    }
    
    // 图片间距
    var imagePandding: CGFloat = 0 {
        didSet {
            updateContentViewLayout()
        }
    }
    
    // 图片圆角
    var imageCornerRadio : CGFloat = 0
    
    init(images: [UIImage]) {
        self.images = images
        super.init()
        backgroundColor = .white
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setupSubviews() {
        addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: pandding, left: pandding, bottom: pandding, right: pandding))
        }
        images.forEach { image in
            let imageView = TYImageCollectView(with: image)
            contentView.addSubview(imageView)
        }
    }
    
    private func updateContentViewLayout() {
        // 图片间距的个数
        let paddingCount : Double = Double(images.count - 1)
        // 每一张图片的高度
        let imageH = (Double(contentView.height) - paddingCount * Double(imagePandding)) / Double(images.count)
        for (index, subView) in contentView.subviews.enumerated() {
            let topOffset = Double(index) * (imageH + Double(imagePandding))
            subView.snp.remakeConstraints { make in
                make.left.right.equalToSuperview()
                make.top.equalToSuperview().offset(topOffset)
                make.height.equalTo(imageH)
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateContentViewLayout()
    }
}
