//
//  TYImageCollectView.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/18.
//  图片收集视图

import UIKit

class TYImageCollectView : TYBaseView {
    
    var image: UIImage?
    
    var pandding : CGFloat = 0 {
        didSet {
            updateSubViews()
        }
    }
    
    var cornerRaido : CGFloat = 0 {
        didSet {
            imageScrollView.cornerRadio = cornerRaido
        }
    }
    
    private lazy var imageScrollView : TYImageScrollView = {
        let scrollView = TYImageScrollView(with: UIImage(named: "blend")!)
        addSubview(scrollView)
        return scrollView
    }()
    
//    convenience init() {
//        self.init(with: nil)
//    }
    
    init(with image: UIImage?) {
        super.init()
        if let img = image {
            self.image = img
            // TODO: 这里后期需要改成imageScrollView中的image非必选
            imageScrollView.image = image!
            imageScrollView.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(UIEdgeInsets(top: pandding, left: pandding, bottom: pandding, right: pandding))
            }
        }
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    func updateSubViews() {
        imageScrollView.snp.remakeConstraints { make in
            make.edges.equalTo(self).inset(UIEdgeInsets(top: pandding, left: pandding, bottom: pandding, right: pandding))
        }
    }
}
