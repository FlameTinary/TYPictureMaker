//
//  TYTextStickerView.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/26.
//

import UIKit

class TYTextStickerView : TYPanView {
    
    var text : String {
        didSet {
            textLbl.text = text
        }
    }
    
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
    
    init(text : String) {
        self.text = text
        super.init(frame: .zero)
        
        backgroundColor = .red
        
        textLbl.text = text
        addSubview(textLbl)
//        addSubview(textField)
//
//        textField.snp.makeConstraints { make in
//            make.center.equalToSuperview()
//            make.width.height.equalToSuperview().multipliedBy(0.9)
//        }
        textLbl.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalToSuperview().multipliedBy(0.9)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
