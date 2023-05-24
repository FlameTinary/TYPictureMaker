//
//  TYBorderEditView.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/22.
//

import UIKit
import RxSwift
import RxCocoa

class TYBorderEditView : TYBaseView {
    
    var pictureBorderValue : Float = 0 {
        didSet {
            pictureSliderView.slider.value = pictureBorderValue
        }
    }
    var imageBorderValue : Float = 0 {
        didSet {
            imageSliderView.slider.value = imageBorderValue
        }
    }
    var imageCornerRadioValue : Float = 0 {
        didSet {
            imageRadioSliderView.slider.value = imageCornerRadioValue
        }
    }
    
    var pictureObserver : Observable<Float>!
    var imageBorderObserver : Observable<Float>!
    var imageCornerRadioObserver : Observable<Float>!
    
    private lazy var pictureSliderView : TYTextSliderView = {
        let v = TYTextSliderView()
        v.textLbl.text = "相框"
        v.slider.minimumValue = 0
        v.slider.maximumValue = 20
        v.slider.value = pictureBorderValue
        addSubview(v)
        return v
    }()
    
    private lazy var imageSliderView : TYTextSliderView = {
        let v = TYTextSliderView()
        v.textLbl.text = "图框"
        v.slider.minimumValue = 0
        v.slider.maximumValue = 20
        v.slider.value = imageBorderValue
        addSubview(v)
        return v
    }()
    
    private lazy var imageRadioSliderView : TYTextSliderView = {
        let v = TYTextSliderView()
        v.textLbl.text = "圆角"
        v.slider.minimumValue = 0
        v.slider.maximumValue = 40
        v.slider.value = imageCornerRadioValue
        addSubview(v)
        return v
    }()
    override init() {
        super.init()
        pictureObserver = pictureSliderView.sliderObserver
        imageBorderObserver = imageSliderView.sliderObserver
        imageCornerRadioObserver = imageRadioSliderView.sliderObserver
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setupSubviews() {
        pictureSliderView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(44)
        }
        
        imageSliderView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(pictureSliderView.snp_bottomMargin).offset(10)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(44)
        }
        
        imageRadioSliderView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(imageSliderView.snp_bottomMargin).offset(10)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(44)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("点击了TYBorderEditView")
    }
}
