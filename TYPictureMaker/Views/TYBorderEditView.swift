//
//  TYBorderEditView.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/22.
//

import UIKit

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
    
    var pictureValueChanged : ((_ value: Float)->Void)? {
        didSet {
            pictureSliderView.sliderValueDidChanged = pictureValueChanged
        }
        
    }
    var imageBorderValueChanged : ((_ value: Float)->Void)? {
        didSet {
            imageSliderView.sliderValueDidChanged = imageBorderValueChanged
        }
    }
    var imageCornerRadioValueChanged : ((_ value: Float)->Void)? {
        didSet {
            imageRadioSliderView.sliderValueDidChanged = imageCornerRadioValueChanged
        }
    }
    
    private lazy var pictureSliderView : TYTextSliderView = {
        let v = TYTextSliderView()
        v.iconView.image = UIImage(named: "border")
        v.slider.minimumValue = 0
        v.slider.maximumValue = 20
        v.slider.minimumValueImage = UIImage(named: "")
        v.slider.maximumValueImage = UIImage(named: "")
        v.slider.value = pictureBorderValue
        addSubview(v)
        return v
    }()
    
    private lazy var imageSliderView : TYTextSliderView = {
        let v = TYTextSliderView()
        v.iconView.image = UIImage(named: "border_inner")
        v.slider.minimumValue = 0
        v.slider.maximumValue = 20
        v.slider.value = imageBorderValue
        addSubview(v)
        return v
    }()
    
    private lazy var imageRadioSliderView : TYTextSliderView = {
        let v = TYTextSliderView()
        v.iconView.image = UIImage(named: "rounded_corner")
        v.slider.minimumValue = 0
        v.slider.maximumValue = 40
        v.slider.value = imageCornerRadioValue
        addSubview(v)
        return v
    }()
    override init() {
        super.init()
//        pictureObserver = pictureSliderView.sliderObserver
//        imageBorderObserver = imageSliderView.sliderObserver
//        imageCornerRadioObserver = imageRadioSliderView.sliderObserver
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setupSubviews() {
        pictureSliderView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
        
        imageSliderView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(pictureSliderView.snp.bottom).offset(8)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
        
        imageRadioSliderView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(imageSliderView.snp.bottom).offset(8)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("点击了TYBorderEditView")
    }
}
