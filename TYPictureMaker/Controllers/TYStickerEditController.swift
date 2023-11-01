//
//  TYTiezhiEditController.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/26.
//

import UIKit

class TYStickerEditController : TYOprationEditController {

    private let stickerImageNames = ["tiezhi_01", "tiezhi_02", "tiezhi_03", "tiezhi_04", "tiezhi_05"]

    private let cellId = "stickerCellId"

    private lazy var stickerCollectionView : UICollectionView = {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: 50, height: 50)

        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .clear
        view.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        view.register(TYLayoutEditCell.self, forCellWithReuseIdentifier: cellId)
        view.dataSource = self
        view.delegate = self

        return view
    }()

    override func setupSubviews() {
        aleatHeight = 100
        super.setupSubviews()
        alertView.addSubview(stickerCollectionView)

        stickerCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(28)
            make.left.right.equalToSuperview()
            if stickerCollectionView.safeBottom == 0 {
                make.bottom.equalTo(-20)
            }else {
                make.bottom.equalTo(-stickerCollectionView.safeBottom)
            }
        }

    }
}

// collection view delegate & data source
extension TYStickerEditController: UICollectionViewDelegate & UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stickerImageNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TYLayoutEditCell
        cell.imageName = stickerImageNames[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let stickView = TYImageStickerView()
//        stickView.width = 150
//        stickView.height = 150
//        stickView.centerX = self.editView.centerX
//        stickView.centerY = self.editView.centerY
        stickView.imageName = self.stickerImageNames[indexPath.item]
        self.editView.addSubview(stickView)
        self.editInfo.stickerNames.append(self.stickerImageNames[indexPath.item])
        stickView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 150, height: 150))
        }
    }
}
