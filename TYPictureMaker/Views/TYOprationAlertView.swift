//
//  TYOprationAlertView.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/25.
//

import UIKit
//import RxSwift
//import RxCocoa

class TYOprationAlertView : TYBaseView {
    
//    var isShowCloseBtn : Bool = true {
//        didSet {
//            closeBtn.isHidden = !isShowCloseBtn
//        }
//    }
//    var closeBtnDidClick : ((_ sender: UIButton) -> Void)?
//    var closeObserver : ControlEvent<Void>!
    
//    private lazy var closeBtn : UIButton = {
//        let btn = UIButton(type: .custom)
//        btn.setImage(UIImage(named: "closeBtn"), for: .normal)
////        btn.isHidden = !isShowCloseBtn
////        closeObserver = btn.rx.tap
//        btn.addTarget(self, action: #selector(closeBtnClick), for: .touchUpInside)
//        return btn
//    }()
    
    override func setupSubviews() {
        super.setupSubviews()
        backgroundColor = editBackgroundColor
//        addSubview(closeBtn)
//        closeBtn.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(4)
//            make.right.equalToSuperview().offset(-4)
//            make.size.equalTo(CGSize(width: 20, height: 20))
//        }
    }
    
//    @objc private func closeBtnClick(sender: UIButton) {
//        if let callback = closeBtnDidClick {
//            callback(sender)
//        }
//    }
}
