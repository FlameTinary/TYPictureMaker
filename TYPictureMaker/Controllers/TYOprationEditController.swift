//
//  TYOprationEditController.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/23.
//

import UIKit
import SnapKit

class TYOprationEditController : TYBaseViewController {
    
    var editView : UIView?
    
    var dismissViewClosure: ((UIView?) -> Void)?
    
    lazy var alertView : TYOprationAlertView = {
        let view = TYOprationAlertView()
        _ = view.closeObserver.takeUntil(rx.deallocated).subscribe(onNext: {_ in
            self.dismiss(animated: true) {
                self.dismissViewClosure?(self.editView)
            }
        })
        view.backgroundColor = .green
        return view
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupSubviews() {
        view.addSubview(alertView)
        
        alertView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(200)
        }
    }
    
}
