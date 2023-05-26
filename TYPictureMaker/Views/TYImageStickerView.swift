//
//  TYStickerView.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/26.
//

import UIKit

class TYImageStickerView : TYPanView {
    
    private lazy var imageView : UIImageView = {
        let view = UIImageView(image: UIImage(named: "tiezhi_02"))
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
