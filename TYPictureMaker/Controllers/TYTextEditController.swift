//
//  TYTextEditController.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/27.
//

import UIKit
import RxSwift
import RxCocoa

class TYTextEditController : TYOprationEditController {
    
    var textObserver : Observable<String?>!
    
    private var text : String?
    
    private lazy var textFiled : UITextField = {
        let field = UITextField()
        field.placeholder = "请输入文字"
        field.borderStyle = .line
        _ = field.rx.text.takeUntil(self.rx.deallocated).subscribe(onNext: { [weak self] text in
            self?.text = text
        })
        return field
    }()
    
    private lazy var confirmBtn : UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("确认", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .green
        return btn
    }()
    
    override init() {
        super.init()
        textObserver = confirmBtn.rx.tap.map { _ in
            return self.text
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        alertView.addSubview(textFiled)
        alertView.addSubview(confirmBtn)
        
        textFiled.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(28)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(44)
        }
        
        confirmBtn.snp.makeConstraints { make in
            make.top.equalTo(textFiled.snp_bottomMargin).offset(10)
            make.size.equalTo(CGSize(width: 100, height: 44))
            make.centerX.equalToSuperview()
        }
    }
}
