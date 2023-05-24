//
//  TYTextSliderView.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/22.
//

import UIKit
import RxSwift
import RxCocoa

class TYTextSliderView : TYBaseView {
        
    var sliderObserver : Observable<Float>!
    
    lazy var textLbl : UILabel = {
        let lbl = UILabel(frame: .zero)
        addSubview(lbl)
        return lbl
    }()
    
    lazy var slider : UISlider = {
        let s = UISlider(frame: .zero)
        addSubview(s)
        return s
    }()
    override init() {
        super.init()
        sliderObserver = slider.rx.value.asObservable()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setupSubviews() {
        textLbl.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
        }
        slider.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(textLbl.snp.right).offset(10)
            make.right.equalToSuperview()
        }
    }
    
}
