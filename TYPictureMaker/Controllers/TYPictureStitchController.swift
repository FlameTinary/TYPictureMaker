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
import Toast_Swift
import ZLPhotoBrowser

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
    
    //操作列表item
    private var oprationItem : [TYOpration]!
    
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
        
        // 创建一个按钮
        let saveButton = UIButton(type: .custom)
        saveButton.frame = CGRect(x: 0, y: 0, width: 60, height: 30)
        saveButton.setTitle("保存", for: .normal)
        saveButton.titleLabel?.font = normalFont
        saveButton.setTitleColor(normalTextColor, for: .normal)
        saveButton.backgroundColor = UIColor(hexString: "#1296db")
        saveButton.layer.cornerRadius = 4.0
        saveButton.addTarget(self, action: #selector(saveClick), for: .touchUpInside)

        // 创建一个自定义视图
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
        customView.backgroundColor = selectColor
        customView.layer.cornerRadius = 4
        customView.addSubview(saveButton)

        // 创建一个UIBarButtonItem，并将自定义视图设置为customView
        let barButtonItem = UIBarButtonItem(customView: customView)

        // 设置导航栏右侧按钮
        navigationItem.rightBarButtonItem = barButtonItem

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        oprationItem = editInfo.layout.supportOpration()
        oprationListView.reloadData()
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
    
    @objc func saveClick() {
        // 在这里实现按钮点击后的逻辑
        let image = editView.getImageFromView()

        // 保存图片到相册
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(imageSaved(_:didFinishSavingWithError:contextInfo:)), nil)

    }
    
    @objc func imageSaved(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // 图片保存失败
            view.makeToast("保存图片到相册失败: \(error.localizedDescription)", duration: 1.0, position: .center)
        } else {
            // 图片保存成功
            view.makeToast("图片保存成功", duration: 1.0, position: .center)
        }
    }

}

// collection view delegate & data source
extension TYPictureStitchController: UICollectionViewDelegate & UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return oprationItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "oprationCellId", for: indexPath) as! TYOprationCell
        let itemName = oprationItem[indexPath.item].toName()
        let itemIcon = oprationItem[indexPath.item].toIcon()
        cell.text = itemName
        cell.icon = itemIcon
        cell.selectedIcon = itemIcon + "_selected"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let opration = oprationItem[indexPath.item]
        if opration == .addImage {
            // 打开相册
            let ps = ZLPhotoPreviewSheet()
            ps.selectImageBlock = { results, isOriginal in
                let image : UIImage = results.map{$0.image}.first!
                let stickView = TYImageStickerView()
                stickView.width = 150
                stickView.height = 150
                stickView.centerX = self.editView.centerX
                stickView.centerY = self.editView.centerY
                stickView.image = image
                self.editView.addSubview(stickView)
            }
            ps.showPreview(sender: self)
        } else {
            presentOprationController(with: opration)
        }
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


