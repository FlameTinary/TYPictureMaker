//
//  TYMainViewController.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/17.
//  主控制器

import UIKit
import SnapKit
import ZLPhotoBrowser

class TYMainViewController: UIViewController  {
    
    private lazy var pingtuBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("快速拼图", for: .normal)
        btn.setTitleColor(.red, for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        navigationItem.title = "快速拼图"
        setupSubViews()
    }
    
    func setupSubViews() {
        pingtuBtn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        view.addSubview(pingtuBtn)
    
        pingtuBtn.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.width.equalTo(100)
            make.height.equalTo(44)
        }
    }
    
    @objc func btnClick(sender: UIButton){
        // 打开相册
        let ps = ZLPhotoPreviewSheet()
        ps.selectImageBlock = { [weak self] results, isOriginal in
            
            let psVC = TYPictureStitchController(images: results.map{$0.image})
            self?.navigationController?.pushViewController(psVC, animated: true)
            
        }
        ps.showPhotoLibrary(sender: self)
    }
}
