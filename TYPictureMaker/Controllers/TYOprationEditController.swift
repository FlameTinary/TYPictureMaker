//
//  TYOprationEditController.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/23.
//

import UIKit
class TYOprationEditController : TYBaseViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .custom
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        dismiss(animated: true)
    }
    
}
