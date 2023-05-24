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
    
    var selectedLayoutEdit : TYLayoutEditEnum = .vertical {
        didSet {
            layoutScrollView.selectItem(at: IndexPath(item: selectedLayoutEdit.rawValue, section: 0), animated: true, scrollPosition: .top)
        }
    }
    var itemSelectedObserver : Observable<IndexPath>!
    
    private let cellId = "layoutCellId"
    
    private lazy var layoutScrollView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 1
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: 50, height: 50)
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .clear
        view.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        view.register(TYLayoutEditCell.self, forCellWithReuseIdentifier: cellId)
        view.dataSource = self
        view.delegate = self
        view.selectItem(at: IndexPath(item: selectedLayoutEdit.rawValue, section: 0), animated: true, scrollPosition: .top)
        return view
    }()
    
    override init() {
        super.init()
        itemSelectedObserver = layoutScrollView.rx.itemSelected.asObservable()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        alertView.addSubview(layoutScrollView)
        
        alertView.snp.remakeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(100)
        }
        
        layoutScrollView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

// collection view delegate & data source
extension TYLayoutEditController: UICollectionViewDelegate & UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TYLayoutEditEnum.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TYLayoutEditCell
        cell.imageName = TYLayoutEditEnum(rawValue: indexPath.item)?.iconNameFromEnum()
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let layoutEdit = TYLayoutEditEnum(rawValue: indexPath.item)
//    }
     
}
