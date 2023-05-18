//
//  TYUpdownView.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/17.
//

import UIKit

class TYUpdownView: UIView {
    var topImage: UIImage
    var bottomImage: UIImage
    
    init(topImage: UIImage, bottomImage: UIImage) {
        self.topImage = topImage
        self.bottomImage = bottomImage
        super.init(frame: .zero)
        setupSubViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubViews() {
        let topImageView = TYImageCollectView(with: topImage)
        let bottomImageView = TYImageCollectView(with: bottomImage)
        self.addSubview(topImageView)
        self.addSubview(bottomImageView)
        topImageView.snp.makeConstraints { make in
            make.left.top.right.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.5)
        }
        bottomImageView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(topImageView)
        }
    }
}
