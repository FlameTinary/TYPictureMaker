//
//  TYOprationCell.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/22.
//

import UIKit

class TYImageAndTextCell: UICollectionViewCell {
    var text : String? {
        didSet {
            textLbl.text = text
        }
    }
    
    var image : UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    var selectedImage : UIImage?
    
    private lazy var textLbl : UILabel = {
        let lbl = UILabel()
        lbl.textColor = normalTextColor
        lbl.font = normalFont
        lbl.textAlignment = .center
        contentView.addSubview(lbl)
        return lbl
    }()
    
    private lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        contentView.addSubview(imageView)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        contentView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
        
        textLbl.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self)
            make.height.greaterThanOrEqualTo(10)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(textLbl.snp.top).offset(-4)
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            if (isSelected) {
                textLbl.textColor = selectColor
                if let selectedImage = selectedImage {
                    imageView.image = selectedImage
                } else {
                    imageView.image = image
                }
            } else {
                textLbl.textColor = normalTextColor
                imageView.image = image
            }
        }
    }
    
}
