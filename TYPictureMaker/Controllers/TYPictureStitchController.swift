//
//  TYPictureStitchController.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/17.
//  图片拼接控制器

import UIKit

class TYPictureStitchController: UIViewController {
    
    var images: [UIImage]?
    
    // 比例item选中的row
    private var proportionSelectedItem = 0
    
    // 比例列表
    private let proportionList = ["1:1", "4:5", "2:1", "4:3", "2:3", "9:16", "16:9"]
    
    // 图片比例列表
    private lazy var proportionListView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(TYProportionCell.self, forCellWithReuseIdentifier: "cellId")
        return collectionView
    }()
    
    init(images: [UIImage]) {
        super.init(nibName: nil, bundle: nil)
        self.images = images
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        setupSubViews()
    }
    
    func setupSubViews() {
        guard let images = self.images else {
            return
        }
        
        let updownView: TYUpdownView = TYUpdownView(topImage: images.first!, bottomImage: images.last!)
        view.addSubview(updownView)
        updownView.snp.makeConstraints { make in
            make.top.equalTo(200)
            make.left.equalTo(100)
            make.right.equalTo(-100)
            make.height.equalTo(300)
        }
        
        proportionListView.delegate = self
        proportionListView.dataSource = self
        view.addSubview(proportionListView)
        // 进入页面默认选中第一个
        proportionListView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .top)
        proportionListView.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.left.right.equalTo(view)
            make.bottom.equalTo(-100)
        }
    }
}

extension TYPictureStitchController: UICollectionViewDelegate & UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return proportionList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! TYProportionCell
        cell.text = proportionList[indexPath.item]
        cell.isSelected = indexPath.item == proportionSelectedItem
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        proportionSelectedItem = indexPath.item
    }
     
}

extension TYPictureStitchController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 30)
    }
}
