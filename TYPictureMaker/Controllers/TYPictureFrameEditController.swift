//
//  TYPictureFrameEditController.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/28.
//

import UIKit

class TYPictureFrameEditController : TYOprationEditController {
    
    private var pictureFrames = ["picture_frame_01"]

    private let cellId = "pictureFrameCellId"

    private lazy var frameScrollView : UICollectionView = {

        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 50, height: 50)

        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .clear
        view.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        view.register(TYLayoutEditCell.self, forCellWithReuseIdentifier: cellId)
        view.dataSource = self
        view.delegate = self
        return view
    }()

    override func setupSubviews() {
        super.setupSubviews()

        alertView.addSubview(frameScrollView)

        frameScrollView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(28)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(-frameScrollView.safeBottom)
        }
    }
}

// collection view delegate & data source
extension TYPictureFrameEditController: UICollectionViewDelegate & UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictureFrames.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TYLayoutEditCell
        cell.imageName = pictureFrames[indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let frameName = pictureFrames[indexPath.item]
        editView.frameImage = UIImage(named: frameName)
        editInfo.frameName = frameName
    }

}
