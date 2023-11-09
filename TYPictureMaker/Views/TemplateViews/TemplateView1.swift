//
//  TemplateView1.swift
//  TYPictureMaker
//
//  Created by server on 2023/11/9.
//

import UIKit

class TemplateView1 : TYBaseEditView {
    
    private let imageView : TYImageCollectView = {
        let imageView = TYImageCollectView()
        imageView.backgroundColor = .green
        return imageView
    }()
    private let dividerView : TYBaseView = {
        let view = TYBaseView()
        view.backgroundColor = .lightGray
        return view
    }()
    private let textView : TYTextStickerView = {
        let view = TYTextStickerView(text: "Hello world!")
        return view
    }()
    
    
    override func setupSubviews() {
        super.setupSubviews()
        addSubview(imageView)
        addSubview(dividerView)
        addSubview(textView)
        imageView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(imageView.snp.width)
        }
        dividerView.snp.makeConstraints { make in
            make.bottom.equalTo(textView.snp.top).offset(-10)
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(0.5)
            make.width.equalToSuperview().multipliedBy(0.3)
        }
        textView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(60)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(200)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let path = UIBezierPath()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: imageView.width, y: 0))
        path.addLine(to: CGPoint(x: imageView.width, y: imageView.height))
        path.addLine(to: CGPoint(x: 0, y: imageView.height))
        path.close()
        
//        let shape = CAShapeLayer()
//        shape.path = path.cgPath
//        shape.lineWidth = 0.5
//        shape.lineDashPattern = [5, 5]
//        shape.strokeColor = UIColor.lightGray.cgColor
//        shape.lineJoin = .round
        imageView.shape = .custom(shapePath: path)
    }
}
