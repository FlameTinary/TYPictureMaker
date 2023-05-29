//
//  TYUpdownView.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/17.
//  简易布局

import UIKit
import SnapKit

class TYNormalLayoutView: TYBaseEditView {
    
    // 边框图片
    override var frameImage : UIImage? {
        didSet {
            frameImageView.image = frameImage
        }
    }
    
    override var imagePandding: CGFloat {
        didSet {
            stackView.spacing = imagePandding
        }
    }
    
    override var imageCornerRadio: CGFloat {
        didSet {
            stackView.arrangedSubviews.forEach { view in
                let v = view as! TYImageCollectView
                v.cornerRaido = imageCornerRadio
            }
        }
    }
    
    // 布局方向
    var axis : NSLayoutConstraint.Axis = .vertical {
        didSet {
            stackView.axis = axis
        }
    }
    
    private lazy var stackView : UIStackView = {
        let imageViews : [TYImageCollectView] = images.map { image in TYImageCollectView(with: image)}
        let stackView = UIStackView(arrangedSubviews: imageViews)
        stackView.axis = axis
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = imagePandding
        addSubview(stackView)
        return stackView
    }()
    
    private lazy var frameImageView : UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override func setupSubviews() {
        super.setupSubviews()
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
//    // 边框间距
//    var pandding : CGFloat = 0 {
//        didSet {
//            contentView.snp.remakeConstraints { make in
//                make.edges.equalToSuperview().inset(UIEdgeInsets(top: pandding, left: pandding, bottom: pandding, right: pandding))
//            }
//        }
//    }
//
//    // 图片间距
//    var imagePandding: CGFloat = 0 {
//        didSet {
//            updateContentViewLayout()
//        }
//    }
    
//    override func setupSubviews() {
//        addSubview(contentView)
//
//        contentView.snp.makeConstraints { make in
//            make.edges.equalToSuperview().inset(UIEdgeInsets(top: pandding, left: pandding, bottom: pandding, right: pandding))
//        }
//        images.forEach { image in
//            let imageView = TYImageCollectView(with: image)
//            contentView.addSubview(imageView)
//        }
//    }
    
//    private func updateContentViewLayout() {
//        // 图片间距的个数
//        let paddingCount : Double = Double(images.count - 1)
//        switch axis {
//            
//        case .vertical:
//            // 每一张图片的高度
//            let imageH = (Double(contentView.height) - paddingCount * Double(imagePandding)) / Double(images.count)
//            for (index, subView) in contentView.subviews.enumerated() {
//                let topOffset = Double(index) * (imageH + Double(imagePandding))
//                subView.snp.remakeConstraints { make in
//                    make.left.right.equalToSuperview()
//                    make.top.equalToSuperview().offset(topOffset)
//                    make.height.equalTo(imageH)
//                }
//            }
//        case .horizontal:
//            // 每一张图片的宽度
//            let imageW = (Double(contentView.width) - paddingCount * Double(imagePandding)) / Double(images.count)
//            for (index, subView) in contentView.subviews.enumerated() {
//                let leftOffset = Double(index) * (imageW + Double(imagePandding))
//                subView.snp.remakeConstraints { make in
//                    make.top.bottom.equalToSuperview()
//                    make.left.equalToSuperview().offset(leftOffset)
//                    make.width.equalTo(imageW)
//                }
//            }
//        case .lattice:
//            break
//        }
//        
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        updateContentViewLayout()
//    }
}
