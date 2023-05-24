//
//  TYOprationEditController.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/23.
//

import UIKit
import SnapKit

class TYOprationEditController : TYBaseViewController {
    
    lazy var alertView : UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .custom
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        dismiss(animated: true)
    }
    
}
