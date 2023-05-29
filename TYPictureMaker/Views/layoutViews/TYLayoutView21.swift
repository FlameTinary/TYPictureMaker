//
//  TYLayoutView21.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/29.
//

import UIKit

class TYLayoutView21: TYBaseEditView {
    
    override var imagePandding: CGFloat {
        didSet {
            secCollectView.padding = imagePandding
        }
    }
    
    private lazy var mainCollectView : TYImageCollectView = {
        let view = TYImageCollectView(with: images?.first)
        return view
    }()
    
    private lazy var secCollectView : TYImageCollectView = {
        var image : UIImage? = images?.first
        if let imgs = images {
            if imgs.count > 1 {
                image = imgs[1]
            }
        }
        
        let view = TYImageCollectView(with: image)
        view.padding = 5.0
        return view
    }()
    
    override func setupSubviews() {
        super.setupSubviews()
        
        contentView.addSubview(mainCollectView)
        contentView.addSubview(secCollectView)
        
        mainCollectView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        secCollectView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.size.equalToSuperview().multipliedBy(0.5)
        }
    }
}
