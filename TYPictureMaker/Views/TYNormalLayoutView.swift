//
//  TYUpdownView.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/17.
//  正常垂直布局

import UIKit
import SnapKit

class TYNormalLayoutView: TYBaseView {
    
    var images : [UIImage] {
        willSet {
            stackView.arrangedSubviews.forEach { view in
                view.removeFromSuperview()
            }
        }
        didSet {
            let imageViews : [TYImageCollectView] = images.map { image in TYImageCollectView(with: image)}
            imageViews.forEach { view in
                stackView.addArrangedSubview(view)
            }
            
        }
    }
    
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
        addSubview(stackView)
        return stackView
    }()
    
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
    
    init(images: [UIImage]) {
        self.images = images
        super.init()
        backgroundColor = .white
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setupSubviews() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
    
    func update(pandding: CGFloat) {
        stackView.snp.remakeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: pandding, left: pandding, bottom: pandding, right: pandding))
        }
        
    }
    
    func updateSubView(pandding: CGFloat) {
        stackView.spacing = pandding
    }
    
    func updateSubView(cornerRadio: CGFloat) {
        stackView.arrangedSubviews.forEach { view in
            if (view is TYImageCollectView) {
                let imgView = view as! TYImageCollectView
                imgView.cornerRaido = cornerRadio
            }
        }
    }
}
