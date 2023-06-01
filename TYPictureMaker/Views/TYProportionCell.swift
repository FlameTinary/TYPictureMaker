//
//  TYProportionCell.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/17.
//  图片比例cell

import UIKit

class TYProportionCell: UICollectionViewCell {
    var text : String? {
        didSet {
            textLbl.text = text
        }
    }
    
    private lazy var textLbl : UILabel = {
        let lbl = UILabel()
        lbl.textColor = normalTextColor
        lbl.font = normalFont
        lbl.layer.borderColor = normalTextColor?.cgColor
        lbl.layer.borderWidth = 1.0
        lbl.textAlignment = .center
        contentView.addSubview(lbl)
        return lbl
    }()
    
//    init(text: String) {
//        self.text = text
//        super.init(frame: .zero)
//        self.textLbl.text = text
//
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textLbl.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10))
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            if (isSelected) {
                textLbl.textColor = selectColor
                textLbl.layer.borderColor = selectColor?.cgColor
            } else {
                textLbl.textColor = normalTextColor
                textLbl.layer.borderColor = normalTextColor?.cgColor
            }
        }
    }
}
