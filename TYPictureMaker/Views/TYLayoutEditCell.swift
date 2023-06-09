//
//  TYLayoutEditCell.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/24.
//

import UIKit

class TYLayoutEditCell : UICollectionViewCell {
    
    var image : UIImage? {
        didSet {
            if let img = image {
                imageView.image = img
            }
        }
    }
    
    var imageName: String? {
        didSet {
            if let imgN = imageName {
                imageView.image = UIImage(named: imgN)
            }
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if (isSelected) {
                imageView.layer.borderColor = selectColor?.cgColor
                imageView.layer.borderWidth = 2.0
            } else {
                imageView.layer.borderColor = UIColor.clear.cgColor
                imageView.layer.borderWidth = 0.0
            }
        }
    }
    
    private lazy var imageView : UIImageView = {
        let view = UIImageView(image: UIImage(named: "icon_2_1"))
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = cellColor
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let view = superview
        setNeedsLayout()
        layoutIfNeeded()

        
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)

        var cellFrame = layoutAttributes.frame
        cellFrame.size.height = view?.bounds.size.height ?? size.height
        cellFrame.size.width = view?.bounds.size.height ?? size.width
        layoutAttributes.frame = cellFrame

        return layoutAttributes
    }
}
