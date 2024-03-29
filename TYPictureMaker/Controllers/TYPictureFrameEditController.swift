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
        
        let scale = TYDeviceModel().getAdaptationScale()

        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10 * scale
        layout.minimumInteritemSpacing = 10 * scale
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 50*scale, height: 50*scale)

        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .clear
        view.contentInset = UIEdgeInsets(top: 0, left: 10 * scale, bottom: 0, right: 10 * scale)
        view.register(TYLayoutEditCell.self, forCellWithReuseIdentifier: cellId)
        view.dataSource = self
        view.delegate = self
        return view
    }()

    override func setupSubviews() {
        // 计算aleartCountentHeight的高度
        let layout = frameScrollView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemSize = layout.itemSize
        aleartCountentHeight = itemSize.height + 16
        
        super.setupSubviews()

        alertView.addSubview(frameScrollView)

        frameScrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
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
