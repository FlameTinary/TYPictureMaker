//
//  TYTiezhiEditController.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/26.
//

import UIKit
import RxSwift
import RxCocoa

class TYStickerEditController : TYOprationEditController {
    
    var itemObserver : Observable<String>!
    
    private let stickerImageNames = ["tiezhi_01", "tiezhi_02", "tiezhi_03", "tiezhi_04", "tiezhi_05"]
    
    private let cellId = "stickerCellId"
    
    private lazy var stickerCollectionView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
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
    
    override init() {
        super.init()
        itemObserver = stickerCollectionView.rx.itemSelected.takeUntil(self.rx.deallocated).map({indexPath in
            return self.stickerImageNames[indexPath.item]
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        alertView.addSubview(stickerCollectionView)
        
        stickerCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(-stickerCollectionView.safeBottom)
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
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let name = stickerImageNames[indexPath.item]
//        selectedImageNames.append(name)
//    }
}
