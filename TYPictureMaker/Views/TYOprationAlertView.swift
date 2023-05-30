//
//  TYOprationAlertView.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/25.
//

import UIKit
import RxSwift
import RxCocoa

class TYOprationAlertView : TYBaseView {
    
    var isShowCloseBtn : Bool = true {
        didSet {
            closeBtn.isHidden = !isShowCloseBtn
        }
    }
    
    var closeObserver : ControlEvent<Void>!
    
    private lazy var closeBtn : UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "closeBtn"), for: .normal)
        btn.isHidden = !isShowCloseBtn
        closeObserver = btn.rx.tap
        return btn
    }()
    
    override func setupSubviews() {
        super.setupSubviews()
        
        addSubview(closeBtn)
        closeBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.right.equalToSuperview().offset(-4)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
    }
}
