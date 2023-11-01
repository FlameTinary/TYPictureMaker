//
//  TYBorderEditController.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/22.
//  边框控制器

import UIKit
//import RxSwift
//import RxCocoa

class TYBorderEditController: TYOprationEditController {

//    override var aleatHeight: CGFloat {
//        get {
//            return 200
//        }
//    }
    
    private lazy var borderEditView : TYBorderEditView = {
        let v = TYBorderEditView()
        
        v.pictureBorderValue = editInfo.borderCorner.pictureBorder
        v.imageBorderValue = editInfo.borderCorner.imageBorder
        v.imageCornerRadioValue = editInfo.borderCorner.imageCornerRadio
        v.pictureValueChanged = { [weak self] value in
            self?.editInfo.borderCorner.pictureBorder = value
            self?.editView.padding = CGFloat(value)
        }
        v.imageBorderValueChanged = {[weak self] value in
            self?.editInfo.borderCorner.imageBorder = value
            self?.editView.imagePandding = CGFloat(value)
        }
        v.imageCornerRadioValueChanged = {[weak self] value in
            self?.editInfo.borderCorner.imageCornerRadio = value
            self?.editView.imageCornerRadio = CGFloat(value)
        }
//        _ = v.pictureObserver.takeUntil(rx.deallocated).subscribe(onNext: {[weak self] value in
//            self?.editInfo.borderCorner.pictureBorder = value
//            self?.editView.padding = CGFloat(value)
//        })
//
//        _ = v.imageBorderObserver.takeUntil(rx.deallocated).subscribe(onNext: {[weak self] value in
//            self?.editInfo.borderCorner.imageBorder = value
//            self?.editView.imagePandding = CGFloat(value)
//        })
//
//        _ = v.imageCornerRadioObserver.takeUntil(rx.deallocated).subscribe(onNext: {[weak self] value in
//        })
        return v
    }()
    
    override func setupSubviews() {
        aleatHeight = 200
        super.setupSubviews()
        alertView.addSubview(borderEditView)
        borderEditView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(-borderEditView.safeBottom)
            make.top.equalToSuperview().offset(28)
        }
    }
    
}
