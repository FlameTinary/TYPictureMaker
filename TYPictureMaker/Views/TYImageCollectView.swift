//
//  TYImageCollectView.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/18.
//  图片收集视图

import UIKit

class TYImageCollectView : UIView {
    
    var image: UIImage?
    
    private lazy var imageScrollView : TYImageScrollView = {
        let scrollView = TYImageScrollView(with: UIImage(named: "blend")!)
        addSubview(scrollView)
        return scrollView
    }()
    
    convenience init() {
        self.init(with: nil)
    }
    
    init(with image: UIImage?) {
        super.init(frame: .zero)
        if let img = image {
            self.image = img
            imageScrollView.image = image!
        }
        backgroundColor = .lightGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageScrollView.snp.makeConstraints { make in
            make.edges.equalTo(self).inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
}
