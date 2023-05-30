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
    
    private var images : [UIImage]
    
    // 缩略图
    private var thumbnailImages : [UIImage] = []
    
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
        layout.minimumInteritemSpacing = 10
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
    
    init(images: [UIImage]) {
        self.images = images
        super.init()
        setupThumbnails()
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
        
        layoutScrollView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
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
    
}

// 制作缩略图
extension TYLayoutEditController {
    func setupThumbnails() {
        TYLayoutEditEnum.allCases.forEach { layout in
            let view = layout.toEditView(images: images)
            thumbnailImages.append(view.thumbnail())
        }
    }
}
