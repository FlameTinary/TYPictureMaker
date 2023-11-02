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
    
    private var text : String?
    
    private lazy var textFiled : UITextField = {
        let field = UITextField()
//        field.placeholder = "请输入文字"
        field.tintColor = normalTextColor
        field.textColor = normalTextColor
        field.borderStyle = .line
        
        // 设置圆角半径
        field.layer.cornerRadius = 5.0

        // 创建内容边距
//        let contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: field.frame.height))
        field.leftViewMode = .always
//        field.contentInset = contentInset
        
        // 设置边框颜色为白色
        field.layer.borderColor = UIColor.white.cgColor
        // 设置边框宽度
        field.layer.borderWidth = 1.0
        // 创建富文本样式的 placeholder
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: descTextColor!,
            .font: normalFont
        ]
        let attributedPlaceholder = NSAttributedString(string: "请输入文字", attributes: attributes)

        // 将富文本样式的 placeholder 应用到 UITextField
        field.attributedPlaceholder = attributedPlaceholder
        _ = field.rx.text.takeUntil(self.rx.deallocated).subscribe(onNext: { [weak self] text in
            self?.text = text
        })
        return field
    }()
    
    private lazy var confirmBtn : UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("确认", for: .normal)
        btn.setTitleColor(normalTextColor, for: .normal)
        btn.backgroundColor = selectColor
        btn.layer.cornerRadius = 15
        _ = btn.rx.tap.takeUntil(rx.deallocated).subscribe(onNext: { [weak self] _ in
            // 将文字添加到文字贴纸上
            guard let text = self?.text, text.count > 0 else { return }
            
            let textStickerView = TYTextStickerView(text: text)
            textStickerView.width = 150
            textStickerView.height = 44
            textStickerView.center = self?.editView.center ?? CGPoint(x: 0, y: 0)
            self?.editView.addSubview(textStickerView)
            
        })
        return btn
    }()
    
    override func setupSubviews() {
        let txtFH : CGFloat = 44
        let confirmBtnH : CGFloat = 30
        let margin : CGFloat = 8
        
        aleartCountentHeight = txtFH + confirmBtnH + margin * 3
        super.setupSubviews()
        
        alertView.addSubview(textFiled)
        alertView.addSubview(confirmBtn)
        
        textFiled.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(margin)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(txtFH)
        }
        
        confirmBtn.snp.makeConstraints { make in
            make.top.equalTo(textFiled.snp.bottom).offset(margin)
            make.size.equalTo(CGSize(width: 100, height: confirmBtnH))
            make.centerX.equalToSuperview()
        }
    }
}
