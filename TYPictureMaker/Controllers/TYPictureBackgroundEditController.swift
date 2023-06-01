//
//  TYPictureBackgroundEditController.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/24.
//

import UIKit
import RxSwift
import RxCocoa

class TYPictureBackgroundEditController : TYOprationEditController {
    
    private let cellId = "backgroundCellId"
//
    private lazy var colorScrollView : UICollectionView = {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.estimatedItemSize = CGSize(width: 50, height: 50)

        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .clear
        view.register(TYBackgroundCell.self, forCellWithReuseIdentifier: cellId)
        view.dataSource = self
        view.delegate = self
        view.selectItem(at: IndexPath(item: editInfo.backgroundColor.rawValue, section: 0), animated: true, scrollPosition: .top)
        return view
    }()

    override func setupSubviews() {
        super.setupSubviews()

        alertView.addSubview(colorScrollView)

        colorScrollView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(28)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

// collection view delegate & data source
extension TYPictureBackgroundEditController: UICollectionViewDelegate & UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TYBackgroundColorEnum.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TYBackgroundCell
        cell.backgroundColor = TYBackgroundColorEnum(rawValue: indexPath.item)?.color()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let color = TYBackgroundColorEnum(rawValue: indexPath.item) else {return}
        editInfo.backgroundColor = color
        editView.backgroundColor = color.color()
    }
}
