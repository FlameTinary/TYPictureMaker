//
//  TYBorderEditController.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/22.
//  边框控制器

import UIKit
import RxSwift
import RxCocoa

class TYBorderEditController: TYOprationEditController {
        
//    var pictureBorderValue : Float
//    var imageBorderValue : Float
//    var imageCornerRadioValue : Float
//    
//    var pictureBorderObserver : Observable<Float>!
//    var imageBorderObserver : Observable<Float>!
//    var imageCornerRadioObserver : Observable<Float>!
//    
    private lazy var borderEditView : TYBorderEditView = {
        let v = TYBorderEditView()
        v.backgroundColor = .red
        return v
    }()
    
//    init(pictureBorderValue : Float, imageBorderValue : Float, imageCornerRadioValue : Float) {
//
//        self.pictureBorderValue = pictureBorderValue
//        self.imageBorderValue = imageBorderValue
//        self.imageCornerRadioValue = imageCornerRadioValue
//        super.init()
//
//        pictureBorderObserver = borderEditView.pictureObserver
//        imageBorderObserver = borderEditView.imageBorderObserver
//        imageCornerRadioObserver = borderEditView.imageCornerRadioObserver
//
//        borderEditView.pictureBorderValue = pictureBorderValue
//        borderEditView.imageBorderValue = imageBorderValue
//        borderEditView.imageCornerRadioValue = imageCornerRadioValue
//
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        alertView.addSubview(borderEditView)
        borderEditView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(-borderEditView.safeBottom)
            make.top.equalToSuperview().offset(40)
        }
    }
    
}
