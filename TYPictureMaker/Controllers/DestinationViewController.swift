//
//  DestinationViewController.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/30.
//

import UIKit
import RxSwift
import RxCocoa

class DestinationViewController: UIViewController {
    
    var sourceView: UIView?
    var passViewClosure: ((UIView) -> Void)?
    
    private lazy var transformBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("back", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        _ = btn.rx.tap.takeUntil(self.rx.deallocated).subscribe {[weak self] event in
            self?.dismiss(animated: true, completion: {
                self?.passViewClosure?(self!.sourceView!)
            })
        }
        return btn
    }()
    
    // ...
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        view.addSubview(transformBtn)
        transformBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(100)
            make.size.equalTo(CGSize(width: 100, height: 44))
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sourceView?.backgroundColor = .blue
    }
}
