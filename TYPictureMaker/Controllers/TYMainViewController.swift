//
//  TYMainViewController.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/17.
//  主控制器

import UIKit
import SnapKit
import ZLPhotoBrowser
import RxSwift
import RxCocoa

class TYMainViewController: TYBaseViewController  {
    
    private lazy var imageView : UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFit
        view.addSubview(imageview)
        return imageview
    }()
    
    private lazy var panView : TYImageStickerView = {
        let view = TYImageStickerView()
        return view
    }()
    
    private lazy var pingtuBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("快速拼图", for: .normal)
        btn.setTitleColor(.red, for: .normal)
        _ = btn.rx.tap.takeUntil(self.rx.deallocated).subscribe {[weak self] event in
            // 打开相册
            let ps = ZLPhotoPreviewSheet()
            ps.selectImageBlock = { [weak self] results, isOriginal in
                
                let psVC = TYPictureStitchController(editInfo: TYEditInfo(images: results.map{$0.image}))
                self?.navigationController?.pushViewController(psVC, animated: true)
                
            }
            ps.showPhotoLibrary(sender: self!)
        }
        return btn
    }()
    
    private lazy var transformBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("九宫格切图", for: .normal)
        btn.setTitleColor(.red, for: .normal)
        _ = btn.rx.tap.takeUntil(self.rx.deallocated).subscribe {[weak self] event in
//            // 打开相册
//            let ps = ZLPhotoPreviewSheet()
//            ps.selectImageBlock = { [weak self] results, isOriginal in
//                self?.splitImageIntoNinePieces(image: results.map{$0.image}.first!)
//
//            }
//            ps.showPhotoLibrary(sender: self!)
            
            self?.navigationController?.pushViewController(ViewController(), animated: true)
        }
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "快速拼图"
        
    }
    
    override func setupSubviews() {
        view.addSubview(pingtuBtn)
        view.addSubview(transformBtn)
    
        pingtuBtn.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.width.equalTo(100)
            make.height.equalTo(44)
        }
        
        transformBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(100)
            make.size.equalTo(CGSize(width: 100, height: 44))
        }
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(100)
            make.size.equalTo(CGSize(width: 200, height: 200))
        }

    }
    
}


