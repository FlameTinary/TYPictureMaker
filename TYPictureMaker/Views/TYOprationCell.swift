//
//  TYOprationCell.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/22.
//

import UIKit

class TYOprationCell: UICollectionViewCell {
    var text : String? {
        didSet {
            textLbl.text = text
        }
    }
    
    var icon : String? {
        didSet {
            if let icon = icon {
                iconView.image = UIImage(named: icon)
            }
        }
    }
    
    var selectedIcon : String?
    
    private lazy var textLbl : UILabel = {
        let lbl = UILabel()
        lbl.textColor = normalTextColor
        lbl.font = normalFont
        lbl.textAlignment = .center
        contentView.addSubview(lbl)
        return lbl
    }()
    
    private lazy var iconView : UIImageView = {
        let iconView = UIImageView()
        contentView.addSubview(iconView)
        return iconView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textLbl.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.greaterThanOrEqualTo(10)
        }
        
        iconView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(4)
            make.bottom.equalTo(textLbl.snp_topMargin).offset(-4)
            make.width.equalTo(iconView.snp.height)
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            if (isSelected) {
                textLbl.textColor = selectColor
                if let selectedIcon = selectedIcon {
                    iconView.image = UIImage(named: selectedIcon)
                }
            } else {
                textLbl.textColor = normalTextColor
                if let icon = icon {
                    iconView.image = UIImage(named: icon)
                }
            }
        }
    }
    
}
