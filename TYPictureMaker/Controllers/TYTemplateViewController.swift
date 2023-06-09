//
//  TYTemplateViewController.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/6/6.
//

import UIKit

class TYTemplateViewController: TYBaseViewController {
    
    private let cellItem = ["image_01", "image_02", "image_02", "image_01","image_01", "image_02", "image_02", "image_01", "image_02", "image_01","image_01", "image_02","image_01", "image_02", "image_02", "image_01"]
    
    private let cellIdentifier = "TemplateCell"
    private let numberOfColumns: Int = 2
    private let cellSpacing: CGFloat = 10
    
    private lazy var collectionView : UICollectionView = {
        let layout = TYWaterfallLayout()
        layout.numberOfColumns = numberOfColumns
        layout.cellSpacing = cellSpacing
        layout.delegate = self
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(TemplateCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: cellSpacing, bottom: 0, right: cellSpacing))
        }
    }
}

// MARK: - UICollectionViewDataSource
extension TYTemplateViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! TemplateCell
        let imageName = cellItem[indexPath.item]
        cell.image = UIImage(named: imageName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("点击选中了\(indexPath.item)")
        let editInfo = TYEditInfo(images: [UIImage(named: "image_01")!, UIImage(named: "image_02")!])
        navigationController?.pushViewController(TYPictureStitchController(editInfo: editInfo), animated: true)
    }
}

extension TYTemplateViewController : TYWaterfallLayoutDelegate {
    
    var cellWidth : CGFloat {
        get {
            return (collectionView.width - CGFloat(numberOfColumns - 1) * cellSpacing) / CGFloat(numberOfColumns)
        }
    }
    
    func heightForRowAtIndexPath(indexPath: IndexPath) -> CGFloat {
        let imageName = cellItem[indexPath.item]
        guard let image = UIImage(named: imageName) else {return 0}
        let imageSizeRadio = image.size.width / image.size.height
        return cellWidth / imageSizeRadio
    }
}
