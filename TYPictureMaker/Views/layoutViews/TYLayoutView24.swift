//
//  TYLayoutView22.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/30.
//

import UIKit

class TYLayoutView24 : TYBaseEditView {
    override var images: [UIImage]? {
        didSet {
            print("image did set")
            guard let images = images else { return}
            for (index, image) in images.enumerated(){
                let v = stackView.arrangedSubviews[index] as! TYImageCollectView
                v.image = image
            }
        }
    }
    override var imagePandding: CGFloat {
        didSet {
            stackView.spacing = imagePandding
        }
    }
    
    // 布局方向
    var axis : NSLayoutConstraint.Axis = .vertical {
        didSet {
            stackView.axis = axis
        }
    }
    
    private lazy var stackView : UIStackView = {
        let imageViews : [TYImageCollectView]? = images?.map { image in
            let view = TYImageCollectView(with: image)
            view.shape = .circle
            return view
        }
        let stackView = UIStackView(arrangedSubviews: imageViews ?? [TYImageCollectView()])
        stackView.axis = axis
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = imagePandding
        addSubview(stackView)
        return stackView
    }()
    
    override func setupSubviews() {
        super.setupSubviews()
        
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
