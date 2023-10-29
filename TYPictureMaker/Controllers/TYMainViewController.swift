//
//  TYMainViewController.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/17.
//  主控制器

import UIKit
import SnapKit

class TYMainViewController: TYBaseViewController  {
    
    private lazy var imageView : UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    private lazy var panView : TYImageStickerView = {
        let view = TYImageStickerView()
        return view
    }()
    
    private lazy var pingtuBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.tag = 1
        btn.setTitle("快速拼图", for: .normal)
        btn.setTitleColor(accentColor, for: .normal)
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        return btn
    }()
    
    private lazy var transformBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.tag = 2
        btn.setTitle("九宫格切图", for: .normal)
        btn.setTitleColor(accentColor, for: .normal)
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        return btn
    }()
    
    private lazy var combineBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.tag = 3
        btn.setTitle("拼长图", for: .normal)
        btn.setTitleColor(accentColor, for: .normal)
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        return btn
    }()
    private lazy var templateBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.tag = 4
        btn.setTitle("模版", for: .normal)
        btn.setTitleColor(accentColor, for: .normal)
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "快速拼图"
        
    }
    
    override func setupSubviews() {
        view.addSubview(imageView)
        view.addSubview(pingtuBtn)
        view.addSubview(transformBtn)
        view.addSubview(combineBtn)
        view.addSubview(templateBtn)
    
        pingtuBtn.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.width.equalTo(200)
            make.height.equalTo(100)
        }
        
        transformBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(100)
            make.size.equalTo(CGSize(width: 100, height: 44))
        }
        
        combineBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(50)
            make.size.equalTo(CGSize(width: 100, height: 44))
        }
        
        templateBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(150)
            make.size.equalTo(CGSize(width: 100, height: 44))
        }
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(100)
            make.size.equalTo(CGSize(width: 200, height: 200))
        }

    }
    
    @objc private func btnClick(sender: UIButton) {
        switch sender.tag {
        case 1: // 快速拼图
            TYPhotoPicker.pickImages(sender: self) { results, asset, isOriginal in
                let psVC = TYPictureStitchController(editInfo: TYEditInfo(images: results))
                self.navigationController?.pushViewController(psVC, animated: true)
            }
        case 2: // 跳转九宫格
            self.navigationController?.pushViewController(TYNinePiecesController(), animated: true)
        case 3: // 跳转拼长图
            self.navigationController?.pushViewController(TYCombineImagesViewController(), animated: true)
        case 4: // 跳转模板
            self.navigationController?.pushViewController(TYTemplateViewController(), animated: true)
        default:
            print(sender.tag)
        }
        
    }
    
}


