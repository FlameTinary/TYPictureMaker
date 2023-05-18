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
    
    private var selectedColor : UIColor = .red
    private var normalColor : UIColor = .black
    
    
    private lazy var textLbl : UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.frame = contentView.bounds
        return lbl
    }()
    
    init(text: String) {
        self.text = text
        super.init(frame: .zero)
        self.textLbl.text = text
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(textLbl)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            if (isSelected) {
                textLbl.textColor = selectedColor
            } else {
                textLbl.textColor = normalColor
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textLbl.frame = contentView.bounds
    }
}
