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
    
    private lazy var panView : TYImageStickerView = {
        let view = TYImageStickerView()
        return view
    }()
    
    private lazy var textStickerView : TYTextStickerView = {
        let textStickerView = TYTextStickerView()
        return textStickerView
    }()
    
    private lazy var pingtuBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("快速拼图", for: .normal)
        btn.setTitleColor(.red, for: .normal)
        _ = btn.rx.tap.takeUntil(self.rx.deallocated).subscribe {[weak self] event in
            // 打开相册
            let ps = ZLPhotoPreviewSheet()
            ps.selectImageBlock = { [weak self] results, isOriginal in
                
                let psVC = TYPictureStitchController(images: results.map{$0.image})
                self?.navigationController?.pushViewController(psVC, animated: true)
                
            }
            ps.showPhotoLibrary(sender: self!)
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
//        view.addSubview(panView)
        view.addSubview(textStickerView)
    
        pingtuBtn.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.width.equalTo(100)
            make.height.equalTo(44)
        }
//
//        panView.snp.makeConstraints { make in
//            make.center.equalToSuperview()
//            make.size.equalTo(CGSize(width: 100, height: 100))
//        }
        
        textStickerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 200, height: 100))
        }
    }
    
}
