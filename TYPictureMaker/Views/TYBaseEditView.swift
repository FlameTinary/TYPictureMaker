//
//  TYBaseEditView.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/28.
//

import UIKit

class TYBaseEditView: TYBaseView {
    
    // 图片集
    var images : [UIImage]
    
    // 背景图片
    var backgroundImage: UIImage?
    
    // 边框图片
    var frameImage: UIImage?
    
    // 图片间距
    var imagePandding: CGFloat = 4
//    {
//        didSet {
//            updateContentViewLayout()
//        }
//    }
    
    // 图片圆角
    var imageCornerRadio : CGFloat = 4
    
    // 保存内容的视图
    lazy var contentView : UIView = {
        let view = UIView()
        return view
    }()
    
    var padding : CGFloat = 4 {
        didSet {
            contentView.snp.remakeConstraints { make in
                make.edges.equalToSuperview().inset(UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
            }
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
        super.setupSubviews()
        addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
        }
    }
    
    func getImageFromView() -> UIImage {
        // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        layer.render(in: context!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    func thumbnail() -> UIImage {
        frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        layoutIfNeeded()
        return getImageFromView()
    }
}
