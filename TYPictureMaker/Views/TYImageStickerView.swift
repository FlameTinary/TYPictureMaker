//
//  TYStickerView.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/26.
//

import UIKit

class TYImageStickerView : TYPanView {
    
    var imageName : String? = "tiezhi_01" {
        didSet {
            if let imageName = imageName {
                imageView.image = UIImage(named: imageName)
            }
        }
    }
    
    var image : UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    private lazy var imageView : UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalToSuperview().multipliedBy(0.9)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
