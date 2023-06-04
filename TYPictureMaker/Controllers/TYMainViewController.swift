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
        btn.setTitle("转场动画", for: .normal)
        btn.setTitleColor(.red, for: .normal)
        _ = btn.rx.tap.takeUntil(self.rx.deallocated).subscribe {[weak self] event in
//            self!.navigationController?.pushViewController(SourceViewController(), animated: true)
            
            let filterManager = TYFilterManager.shared
            guard let image = UIImage(named: "image_02") else { return }

            let filter = TYFilterEnum.old
            guard let filteredImage = filter.toImage(image: image) else {return}
            self?.imageView.image = filteredImage
        }
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "快速拼图"
        

        
//        let irregularView = IrregularQuadrilateralView(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
//        irregularView.backgroundColor = UIColor.red
        // 添加其他的子视图或内容到irregularView中

//        view.addSubview(irregularView)
//
//        let circularView = CircularView(frame: CGRect(x: 100, y: 400, width: 200, height: 200))
//        circularView.backgroundColor = UIColor.red
//        // 添加其他的子视图或内容到circularView中
//
//        view.addSubview(circularView)
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
