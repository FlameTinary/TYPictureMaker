//
//  TYTextSliderView.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/22.
//

import UIKit
//import RxSwift
//import RxCocoa

class TYTextSliderView : TYBaseView {
        
//    var sliderObserver : Observable<Float>!
//    private var sliderObserver : NSKeyValueObservation?
    
    var sliderValueDidChanged: ((_ value: Float)->Void)?
    
    lazy var iconView : UIImageView = {
        let view = UIImageView()
//        lbl.font = normalFont
//        lbl.textColor = normalTextColor
        addSubview(view)
        return view
    }()
    
    lazy var slider : UISlider = {
        let s = UISlider(frame: .zero)
        s.minimumTrackTintColor = selectColor
        s.maximumTrackTintColor = .white
        s.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
        addSubview(s)
        return s
    }()
    
    override init() {
        super.init()
//        sliderObserver = slider.rx.value.asObservable()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupSubviews() {
        
        iconView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        slider.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(iconView.snp.right).offset(10)
            make.right.equalToSuperview()
        }
    }
    
    @objc private func sliderChanged(sender: UISlider) {
        let newValue = sender.value
        print("Slider's value changed to: \(newValue)")
        if let callback = sliderValueDidChanged {
            callback(newValue)
        }
    }
    
}
