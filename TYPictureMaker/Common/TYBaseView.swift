//
//  TYBaseView.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/24.
//

import UIKit

class TYBaseView : UIView {
    
    init() {
        super.init(frame: .zero)
        setupSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        
    }
}
