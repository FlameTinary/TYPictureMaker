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
        
//        let irregularView = IrregularQuadrilateralView(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
//        irregularView.backgroundColor = UIColor.red
//        // 添加其他的子视图或内容到irregularView中
//
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
    
        pingtuBtn.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.width.equalTo(100)
            make.height.equalTo(44)
        }

    }
    
}
