//
//  TYLayoutEditController.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/23.
//  布局控制器

import UIKit
import RxSwift
import RxCocoa

class TYLayoutEditController : TYOprationEditController {

    // 缩略图
    private var thumbnailImages : [UIImage] = []

    private let cellId = "layoutCellId"

    private lazy var layoutScrollView : UICollectionView = {

        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 50, height: 50)

        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .clear
        view.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        view.register(TYLayoutEditCell.self, forCellWithReuseIdentifier: cellId)
        view.dataSource = self
        view.delegate = self
        view.selectItem(at: IndexPath(item: editInfo.layout.rawValue, section: 0), animated: true, scrollPosition: .top)
        return view
    }()

    override func setupSubviews() {
        super.setupSubviews()
        
        setupThumbnails()

        alertView.addSubview(layoutScrollView)

        layoutScrollView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(28)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(-layoutScrollView.safeBottom)
        }
    }
}

// collection view delegate & data source
extension TYLayoutEditController: UICollectionViewDelegate & UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return thumbnailImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TYLayoutEditCell
        cell.image = thumbnailImages[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let layout = TYLayoutEditEnum(rawValue: indexPath.item)
        editInfo.layout = layout!
        
        let editView = layout!.toEditView(images: editInfo.images)
        editView.padding = CGFloat(editInfo.borderCorner.pictureBorder)
        editView.imagePandding = CGFloat(editInfo.borderCorner.imageBorder)
        editView.imageCornerRadio = CGFloat(editInfo.borderCorner.imageCornerRadio)
        editView.backgroundColor = editInfo.backgroundColor.color()
        editView.backgroundImage = editInfo.backgroundImage
        editView.frame = self.editView.frame
        
        self.view.insertSubview(editView, at: 0)
        
        self.editView.removeFromSuperview()
        
        self.editView = editView
    }
    
}
//
// 制作缩略图
extension TYLayoutEditController {
    func setupThumbnails() {
        TYLayoutEditEnum.allCases.forEach { layout in
            let view = layout.toEditView(images: editInfo.images)
            view.padding = 2
            view.imagePandding = 2
            view.imageCornerRadio = 2
            view.backgroundColor = .white
            thumbnailImages.append(view.thumbnail())
        }
    }
}
