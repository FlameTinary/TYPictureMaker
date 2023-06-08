//
//  RandomCell.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/6/7.
//

import UIKit
import SnapKit

class TemplateCell : UICollectionViewCell {
    
    var image : UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    private lazy var imageView : UIImageView = {
        let view = UIImageView(image: UIImage(named: "image_01"))
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
