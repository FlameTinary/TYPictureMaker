//
//  TYProportionEditController.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class TYProportionEditController : TYOprationEditController {
    
    var selectedProportion : TYProportion = .oneToOne {
        didSet {
            proportionScrollView.selectItem(at: IndexPath(item: selectedProportion.rawValue, section: 0), animated: true, scrollPosition: .top)
        }
    }
    
    var itemSelectedObserver : Observable<IndexPath>!

    private let cellId = "proportionCellId"
    
    private lazy var proportionScrollView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: 70, height: 50)
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .clear
        view.register(TYProportionCell.self, forCellWithReuseIdentifier: cellId)
        view.dataSource = self
        view.delegate = self
        view.selectItem(at: IndexPath(item: selectedProportion.rawValue, section: 0), animated: true, scrollPosition: .top)
        return view
    }()
    
    override init() {
        super.init()
        itemSelectedObserver = proportionScrollView.rx.itemSelected.asObservable()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        alertView.addSubview(proportionScrollView)
        
        proportionScrollView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(40)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
}

// collection view delegate & data source
extension TYProportionEditController: UICollectionViewDelegate & UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TYProportion.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TYProportionCell
        cell.text = TYProportion(rawValue: indexPath.item)?.toName()
        return cell
    }
     
}
