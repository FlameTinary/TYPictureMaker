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
    
    var pictureObserver : Observable<Float>!
    var imageBorderObserver : Observable<Float>!
    var imageCornerRadioObserver : Observable<Float>!
    
    lazy var pictureSliderView : TYTextSliderView = {
        let v = TYTextSliderView()
        v.textLbl.text = "相框"
        v.slider.minimumValue = 0
        v.slider.maximumValue = 20
        addSubview(v)
        return v
    }()
    
    lazy var imageSliderView : TYTextSliderView = {
        let v = TYTextSliderView()
        v.textLbl.text = "图框"
        v.slider.minimumValue = 0
        v.slider.maximumValue = 20
        addSubview(v)
        return v
    }()
    
    lazy var imageRadioSliderView : TYTextSliderView = {
        let v = TYTextSliderView()
        v.textLbl.text = "圆角"
        v.slider.minimumValue = 0
        v.slider.maximumValue = 40
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
