//
//  TYUpdownView.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/17.
//

import UIKit
import SnapKit

class TYUpdownView: UIView {
    var topImage: UIImage
    var bottomImage: UIImage
    
    var bgView : UIView
    
    var pandding : CGFloat = 0 {
        didSet {
            update(pandding: pandding)
        }
    }
    
    var imagePandding: CGFloat = 0 {
        didSet {
            updateSubView(pandding: imagePandding)
        }
    }
    
    var imageCornerRadio : CGFloat = 0 {
        didSet {
            updateSubView(cornerRadio: imageCornerRadio)
        }
    }
    
    init(topImage: UIImage, bottomImage: UIImage) {
        bgView = UIView(frame: .zero)
        
        self.topImage = topImage
        self.bottomImage = bottomImage
        super.init(frame: .zero)
        setupSubViews()
        backgroundColor = .white
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubViews() {
        bgView = UIView(frame: .zero)
        addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        
        let topImageView = TYImageCollectView(with: topImage)
        let bottomImageView = TYImageCollectView(with: bottomImage)
        bgView.addSubview(topImageView)
        bgView.addSubview(bottomImageView)
        topImageView.snp.makeConstraints { make in
            make.left.top.equalTo(bgView)
            make.right.equalTo(bgView)
            make.height.equalTo(bgView).multipliedBy(0.5)
        }
        bottomImageView.snp.makeConstraints { make in
            make.left.equalTo(bgView)
            make.right.bottom.equalTo(bgView)
            make.height.equalTo(topImageView)
        }
    }
    
    func update(pandding: CGFloat) {
        bgView.snp.remakeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: pandding, left: pandding, bottom: pandding, right: pandding))
        }
    }
    
    func updateSubView(pandding: CGFloat) {
        bgView.subviews.forEach { imageView in
            if (imageView is TYImageCollectView) {
                let imgView = imageView as! TYImageCollectView
                imgView.pandding = pandding
            }
            
        }
    }
    
    func updateSubView(cornerRadio: CGFloat) {
        bgView.subviews.forEach { imageView in
            if (imageView is TYImageCollectView) {
                let imgView = imageView as! TYImageCollectView
                imgView.cornerRaido = cornerRadio
            }
            
        }
    }
}
