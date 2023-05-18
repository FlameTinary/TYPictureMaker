//
//  TYPictureStitchController.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/17.
//  图片拼接控制器

import UIKit
import SnapKit

class TYPictureStitchController: UIViewController {
    
    var images: [UIImage]?
    
    // 比例item选中的row
    private var proportionSelectedItem = 0
    
    // 比例列表
    private let proportionList = ["1:1", "4:5", "2:1", "4:3", "2:3", "9:16", "16:9"]
    
    // 图片展示底视图，用于约束图片展示视图不超过屏幕
    private lazy var bgView : UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        view.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(-50)
            make.width.equalTo(view)
            make.height.equalTo(bgView.snp.width)
        }
        return bgView
    }()
    
    // 图片展示视图
    private var updownView :TYUpdownView?
    
    private var heightConstraint : Constraint?
    
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
        bgView.addSubview(updownView)
        self.updownView = updownView
        // 按照默认选中的显示比例调整视图
        updownView.snp.makeConstraints { make in
            make.edges.equalTo(bgView)
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
        
        // 选中item后按照选中的比例调整updownView视图的显示
        switch proportionSelectedItem {
        case 0:
            self.updownView!.snp.remakeConstraints { make in
                make.edges.equalTo(bgView)
            }
        case 1:
            self.updownView!.snp.remakeConstraints { make in
                make.center.equalTo(bgView)
                make.height.equalTo(bgView)
                make.width.equalTo(bgView).multipliedBy(0.8)
                
            }
        case 2:
            self.updownView!.snp.remakeConstraints { make in
                make.center.equalTo(bgView)
                make.width.equalTo(bgView)
                make.height.equalTo(bgView).multipliedBy(0.5)
            }
        case 3:
            self.updownView!.snp.remakeConstraints { make in
                make.center.equalTo(bgView)
                make.width.equalTo(bgView)
                make.height.equalTo(bgView).multipliedBy(0.75)
            }
        case 4:
            self.updownView!.snp.remakeConstraints { make in
                make.center.equalTo(bgView)
                make.height.equalTo(bgView)
                make.width.equalTo(bgView).multipliedBy(0.667)
            }
        case 5:
            self.updownView!.snp.remakeConstraints { make in
                make.center.equalTo(bgView)
                make.height.equalTo(bgView)
                make.width.equalTo(bgView).multipliedBy(0.5625)
            }
        case 6:
            self.updownView!.snp.remakeConstraints { make in
                make.center.equalTo(bgView)
                make.width.equalTo(bgView)
                make.height.equalTo(bgView).multipliedBy(0.5625)
            }
            
        default:
            updownView!.snp.remakeConstraints { make in
                make.edges.equalTo(bgView)
            }
        }
        view.layoutIfNeeded()
        
    }
     
}

extension TYPictureStitchController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 30)
    }
}
