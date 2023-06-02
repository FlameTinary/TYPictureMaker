//
//  TYPictureStitchController.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/17.
//  图片拼接控制器

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class TYPictureStitchController: TYOprationEditController {
    
//    var images : [UIImage]
    
    override var aleatHeight: CGFloat {
        get {
            return 100
        }
    }
    
    // 选中的贴纸数组
    private var stickerNames : [String] = []
    
    // rx销毁属性
    private var disposeBag = DisposeBag()
    
    // 底部操作列表
    private lazy var oprationListView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 80, height: 50)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(TYOprationCell.self, forCellWithReuseIdentifier: "oprationCellId")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertView.isShowCloseBtn = false
//        setupNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.disposeBag = DisposeBag()
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        alertView.addSubview(oprationListView)

        oprationListView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(alertView).offset(-oprationListView.safeBottom)
        }

    }
    
//    private func setupNotification() {
//
//        let changeFilterNotification = Notification.Name("changeFilter")
//        let filterIntensityNotification = Notification.Name("changeIntensity")
//
//        NotificationCenter.default.rx.notification(changeFilterNotification).subscribe {[weak self] notification in
//            guard let obj = notification.object else {return}
//            self?.editInfo.filter.filter = obj as! TYFilterEnum
//
//        }.disposed(by: self.disposeBag)
//
//        NotificationCenter.default.rx.notification(filterIntensityNotification).subscribe {[weak self] notification in
//            guard let obj = notification.object else {return}
//            self?.editInfo.filter.intensity = obj as! Float
//
//        }.disposed(by: self.disposeBag)
//    }
}

// collection view delegate & data source
extension TYPictureStitchController: UICollectionViewDelegate & UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TYOpration.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "oprationCellId", for: indexPath) as! TYOprationCell
        
        if let opration = TYOpration(rawValue: indexPath.item) {
            cell.text = opration.toName()
            cell.icon = opration.toIcon()
            cell.selectedIcon = opration.toIcon() + "_selected"
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presentOprationController(with: TYOpration(rawValue: indexPath.item)!)
    }
     
}

// 跳转操作控制器
extension TYPictureStitchController {
    private func presentOprationController(with opration: TYOpration) {

        let destinationVC : TYOprationEditController
        
        switch opration {
        case .proportion:
            destinationVC = TYProportionEditController(editInfo: editInfo)
        case .layout:
            destinationVC = TYLayoutEditController(editInfo: editInfo)
        case .border:
            destinationVC = TYBorderEditController(editInfo: editInfo)
        case .background:
            destinationVC = TYPictureBackgroundEditController(editInfo: editInfo)
        case .filter:
            destinationVC = TYFilterEditController(editInfo: editInfo)
        case .text:
            destinationVC = TYTextEditController(editInfo: editInfo)
        case .sticker:
            destinationVC = TYStickerEditController(editInfo: editInfo)
        case .pictureFrame:
            destinationVC = TYPictureFrameEditController(editInfo: editInfo)
        default:
            destinationVC = TYOprationEditController(editInfo: editInfo)
        }
        
        destinationVC.editView = editView
        destinationVC.transitioningDelegate = self
        destinationVC.modalPresentationStyle = .fullScreen

        present(destinationVC, animated: true, completion: nil)

    }
}


