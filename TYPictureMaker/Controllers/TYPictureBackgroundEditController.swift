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
    
//    var selectedColor : TYBackgroundColorEnum = .white {
//        didSet {
//            colorScrollView.selectItem(at: IndexPath(item: selectedColor.rawValue, section: 0), animated: true, scrollPosition: .top)
//        }
//    }
//
//    var itemSelectedObserver : Observable<IndexPath>!
//
//    private let cellId = "backgroundCellId"
//
//    private lazy var colorScrollView : UICollectionView = {
//
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        layout.estimatedItemSize = CGSize(width: 50, height: 50)
//
//        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        view.showsVerticalScrollIndicator = false
//        view.showsHorizontalScrollIndicator = false
//        view.backgroundColor = .clear
//        view.register(TYBackgroundCell.self, forCellWithReuseIdentifier: cellId)
//        view.dataSource = self
//        view.delegate = self
//        view.selectItem(at: IndexPath(item: selectedColor.rawValue, section: 0), animated: true, scrollPosition: .top)
//        return view
//    }()
//
//    override init() {
//        super.init()
//        itemSelectedObserver = colorScrollView.rx.itemSelected.asObservable()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//
//    override func setupSubviews() {
//        super.setupSubviews()
//
//        alertView.addSubview(colorScrollView)
//
//        colorScrollView.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(40)
//            make.left.equalTo(10)
//            make.right.equalTo(-10)
//            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
//        }
//    }
}

// collection view delegate & data source
//extension TYPictureBackgroundEditController: UICollectionViewDelegate & UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return TYBackgroundColorEnum.allCases.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TYBackgroundCell
//        cell.backgroundColor = TYBackgroundColorEnum(rawValue: indexPath.item)?.color()
//        return cell
//    }
//    
//}
//
//extension TYPictureBackgroundEditController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 20
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 20
//    }
//}
