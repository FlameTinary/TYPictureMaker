//
//  TYPictureFrameEditController.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/28.
//

import UIKit
import RxSwift
import RxCocoa

class TYPictureFrameEditController : TYOprationEditController {
    
    var pictureFrameObserver : Observable<String?>!
    
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
    
    override init() {
        super.init()
        self.pictureFrameObserver = frameScrollView.rx.itemSelected.map {[weak self] indexPath in
            return self?.pictureFrames[indexPath.item]
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        alertView.addSubview(frameScrollView)
        
        frameScrollView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
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
    
     
}
