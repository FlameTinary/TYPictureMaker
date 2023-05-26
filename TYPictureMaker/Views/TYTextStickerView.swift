//
//  TYTextStickerView.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/26.
//

import UIKit

class TYTextStickerView : TYPanView {
    
    private lazy var textField : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .green
        textField.borderStyle = .line
        return textField
    }()
    
    private lazy var textLbl : UILabel = {
        let lbl = UILabel()
        lbl.text = "这里是输入的文字"
        lbl.textAlignment = .center
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        addSubview(textLbl)
//        addSubview(textField)
//
//        textField.snp.makeConstraints { make in
//            make.center.equalToSuperview()
//            make.width.height.equalToSuperview().multipliedBy(0.9)
//        }
        textLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
