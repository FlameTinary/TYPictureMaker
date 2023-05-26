//
//  TYTiezhiEditController.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/26.
//

import UIKit

class TYStickerEditController : TYOprationEditController {
    
    private lazy var panView : TYPanView = {
        let view = TYPanView()
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        alertView.addSubview(panView)
        
        panView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
    }
}
