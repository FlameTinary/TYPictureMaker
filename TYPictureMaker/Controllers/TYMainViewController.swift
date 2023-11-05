//
//  TYMainViewController.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/17.
//  主控制器

import UIKit
import SnapKit

class TYMainViewController: TYBaseViewController  {
    
//    private lazy var imageView : UIImageView = {
//        let imageview = UIImageView()
//        imageview.contentMode = .scaleAspectFit
//        imageview.image = UIImage(named: "testImg")
//        return imageview
//    }()
    
    private lazy var imgScrollView : TYLayoutView29 = {
        let imgScrollView = TYLayoutView29(images: nil)
        imgScrollView.backgroundColor = UIColor.green
//        imgScrollView.image = UIImage(named: "testImg")
        imgScrollView.padding = 5
//
//        imgScrollView.shape = .rectangle
        return imgScrollView
    }()
    
    private lazy var panView : TYImageStickerView = {
        let view = TYImageStickerView()
        return view
    }()
    
    private lazy var pingtuBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.tag = 1
        btn.backgroundColor = UIColor(hexString: "#FF9966")
        btn.layer.cornerRadius = 16.0
        btn.setTitle("快速拼图", for: .normal)
        btn.setTitleColor(normalTextColor, for: .normal)
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        return btn
    }()
    
    private lazy var transformBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.tag = 2
        btn.backgroundColor = UIColor(hexString: "#CCFF99")
        btn.layer.cornerRadius = 16.0
        btn.setTitle("九宫格切图", for: .normal)
        btn.setTitleColor(normalTextColor, for: .normal)
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        return btn
    }()
    
    private lazy var combineBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.tag = 3
        btn.backgroundColor = UIColor(hexString: "#99CC99")
        btn.layer.cornerRadius = 16.0
        btn.setTitle("拼长图", for: .normal)
        btn.setTitleColor(normalTextColor, for: .normal)
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        return btn
    }()
    private lazy var templateBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.tag = 4
        btn.backgroundColor = UIColor(hexString: "#99CCFF")
        btn.layer.cornerRadius = 16.0
        btn.setTitle("模版", for: .normal)
        btn.setTitleColor(normalTextColor, for: .normal)
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "快速拼图"
        
    }
    
    override func setupSubviews() {
        
        let deviceModel = TYDeviceModel()
        
//        view.addSubview(imageView)
        view.addSubview(imgScrollView)
        view.addSubview(pingtuBtn)
        view.addSubview(transformBtn)
        view.addSubview(combineBtn)
        view.addSubview(templateBtn)
    
        pingtuBtn.snp.makeConstraints { make in
            make.centerY.equalTo(view).offset(50)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(transformBtn.snp.left).offset(-10)
            make.height.equalTo(pingtuBtn.snp.width).multipliedBy(0.5)
            
        }
        
        transformBtn.snp.makeConstraints { make in
            make.centerY.equalTo(view).offset(50)
            make.right.equalTo(view).offset(-20)
            make.width.equalTo(pingtuBtn.snp.width)
            make.height.equalTo(transformBtn.snp.width).multipliedBy(0.5)
        }
        
        combineBtn.snp.makeConstraints { make in
            make.top.equalTo(pingtuBtn.snp.bottom).offset(10)
            make.left.equalTo(pingtuBtn.snp.left)
            make.size.equalTo(pingtuBtn)
        }
        
        templateBtn.snp.makeConstraints { make in
            make.right.equalTo(transformBtn.snp.right)
            make.top.equalTo(combineBtn)
            make.size.equalTo(combineBtn)
        }
        
//        imageView.snp.makeConstraints { make in
//            let navH = deviceModel.getNavH()
//            let statusH = deviceModel.getStatusBarH()
//            make.left.right.equalTo(view)
//            make.top.equalTo(navH + statusH)
//            make.height.equalTo(imageView.snp.width).multipliedBy(0.5)
//        }
        
        imgScrollView.snp.makeConstraints { make in
            let navH = deviceModel.getNavH()
            let statusH = deviceModel.getStatusBarH()
            let width = 200
            let height = width
//            make.left.right.equalTo(view)
            make.top.equalTo(navH + statusH)
//            make.height.equalTo(imgScrollView.snp.width).multipliedBy(0.5)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: width, height: height))
        }

    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        let startPoint = CGPoint(x: imgScrollView.bounds.midY, y: 0)
//        let endPoint = CGPoint(x: imgScrollView.bounds.midY, y: imgScrollView.height)
//
//        let radius : CGFloat = imgScrollView.bounds.midY
//        let center = CGPoint(x: imgScrollView.bounds.midY, y: imgScrollView.bounds.midY)
//        let path = UIBezierPath()
//        path.addArc(withCenter: center, radius: radius, startAngle: CGFloat.pi/2, endAngle: -CGFloat.pi / 2, clockwise: true)
//        path.addLine(to: endPoint)
//
//        let shapeLayer = CAShapeLayer()
//        shapeLayer.path = path.cgPath
//
//        let borderLayer = CAShapeLayer()
//        borderLayer.path = path.cgPath
//        borderLayer.fillColor = UIColor.clear.cgColor
//        borderLayer.strokeColor = UIColor.gray.cgColor
//        borderLayer.lineWidth = 2.0
//        borderLayer.lineDashPattern = [5, 5]
//        borderLayer.lineJoin = .round
//
//        imgScrollView.layer.mask = shapeLayer
//        imgScrollView.layer.addSublayer(borderLayer)
////        imageView.layer.addSublayer(shapeLayer)
//    }
    
    @objc private func btnClick(sender: UIButton) {
        switch sender.tag {
        case 1: // 快速拼图
            self.pickImages { results, asset, isOriginal in
                let psVC = TYPictureStitchController(editInfo: TYEditInfo(images: results))
                self.navigationController?.pushViewController(psVC, animated: true)
            }
        case 2: // 跳转九宫格
            self.pickImages { results, asset, isOriginal in
                if let image = results.first {
                    let ninepiecesVC = TYNinePiecesController(originImage: image)
                    self.navigationController?.pushViewController(ninepiecesVC, animated: true)
                }
                
            }
        case 3: // 跳转拼长图
            self.pickImages { results, asset, isOriginal in
                let combineImagesVC = TYCombineImagesViewController(originalImages: results)
                self.navigationController?.pushViewController(combineImagesVC, animated: true)
            }
        case 4: // 跳转模板
            self.navigationController?.pushViewController(TYTemplateViewController(), animated: true)
        default:
            print(sender.tag)
        }
        
    }
    
}


