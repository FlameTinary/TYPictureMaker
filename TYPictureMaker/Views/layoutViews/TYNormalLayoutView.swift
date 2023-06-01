//
//  TYUpdownView.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/17.
//  简易布局

import UIKit
import SnapKit

class TYNormalLayoutView: TYBaseEditView {
    
    override var images: [UIImage]? {
        didSet {
            print("image did set")
        }
    }
    
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
        let imageViews : [TYImageCollectView]? = images?.map { image in TYImageCollectView(with: image)}
        let stackView = UIStackView(arrangedSubviews: imageViews ?? [TYImageCollectView()])
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
}
