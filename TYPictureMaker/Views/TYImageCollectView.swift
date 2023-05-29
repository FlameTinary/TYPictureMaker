//
//  TYImageCollectView.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/18.
//  图片收集视图

import UIKit
import ZLPhotoBrowser

import RxSwift
import RxCocoa

class TYImageCollectView : TYBaseView {
    
//    weak var sender : UIViewController?
    
    var image: UIImage? {
        didSet {
            guard let img = image else { return }
            backImageView.isHidden = true
            imageScrollView.isHidden = false
            imageScrollView.image = img
        }
    }
    
    private lazy var backImageView : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "blend"))
        imageView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer()
        imageView.addGestureRecognizer(gesture)
        _ = gesture.rx.event.takeUntil(self.rx.deallocated).bind(onNext: {gesture in
            // 打开相册
            let ps = ZLPhotoPreviewSheet()
            ps.selectImageBlock = { [weak self] results, isOriginal in
                self?.image = results.map{$0.image}.first
                
            }
            if let sender = self.parentViewController {
                ps.showPreview(animate: true, sender: sender)
            }
        })
        return imageView
    }()
    
    var padding : CGFloat = 0 {
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
        return scrollView
    }()
    
    override init() {
        super.init()
        backgroundColor = .cyan
    }
    
    convenience init(with image: UIImage?) {
        self.init()
        if let img = image {
            self.image = img
            backImageView.isHidden = true
            imageScrollView.isHidden = false
            imageScrollView.image = img
            imageScrollView.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
            }
        }
        backgroundColor = .white
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        addSubview(backImageView)
        addSubview(imageScrollView)
        
        imageScrollView.isHidden = image == nil
        
        backImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
        }
        
        imageScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
        }
        
    }
    
    func updateSubViews() {
        
        backImageView.snp.remakeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
        }
        imageScrollView.snp.remakeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension TYImageCollectView {
    
}
