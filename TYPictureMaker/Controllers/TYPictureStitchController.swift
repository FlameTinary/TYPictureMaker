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
    
    // 图片编辑相关信息
//    private var editInfo : TYEditInfo!
    
    // 选中的贴纸数组
    private var stickerNames : [String] = []
    
    // rx销毁属性
    private var disposeBag = DisposeBag()
    
    // 操作item选中row
    private var oprationSelectedItem: TYOpration = .proportion
    {
        didSet {
            presentOprationController(with: oprationSelectedItem)
        }
    }
    
    // 图片展示底视图，用于约束图片展示视图不超过屏幕
//    private lazy var imageContentView : UIView = {
//        let view = UIView()
//        view.size = CGSize(width: self.view.width, height: self.view.width)
//        view.centerX = self.view.centerX
//        view.centerY = self.view.centerY - 50
//        view.backgroundColor = .clear
//        return view
//    }()
    
    // 图片展示视图
//    override var editView: TYBaseEditView?
//    private var imageEditView :TYBaseEditView!
    
    // 底部操作列表
    private lazy var oprationListView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: 80, height: 50)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(TYOprationCell.self, forCellWithReuseIdentifier: "oprationCellId")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        return collectionView
    }()

//    init(images: [UIImage]) {
////        self.images = images
//        editInfo = TYEditInfo(images: images)
//        super.init(editInfo: editInfo)
//
//    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        alertView.isShowCloseBtn = false
        setupNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.disposeBag = DisposeBag()
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        alertView.addSubview(oprationListView)
//        view.addSubview(imageContentView)
        
//        let imageEditView = editInfo.layout.toEditView(images: images)
//        imageEditView.backgroundColor = editInfo.backgroundColor.color()
//        imageEditView.padding = CGFloat(editInfo.borderCorner.pictureBorder)
//        imageEditView.imagePandding = CGFloat(editInfo.borderCorner.imageBorder)
//        imageEditView.imageCornerRadio = CGFloat(editInfo.borderCorner.imageCornerRadio)
//        imageContentView.addSubview(imageEditView)
//        self.imageEditView = imageEditView
        
//        alertView.snp.remakeConstraints { make in
//            make.left.right.equalToSuperview()
//            make.height.equalTo(100)
//            make.bottom.equalTo(0)
//        }
        
        oprationListView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(alertView).offset(-oprationListView.safeBottom)
        }

//        imageEditView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
        
    }
    
    private func setupNotification() {
        
        let changeFilterNotification = Notification.Name("changeFilter")
        let filterIntensityNotification = Notification.Name("changeIntensity")
        
        NotificationCenter.default.rx.notification(changeFilterNotification).subscribe {[weak self] notification in
            guard let obj = notification.object else {return}
            self?.editInfo.filter.filter = obj as! TYFilterEnum
            
        }.disposed(by: self.disposeBag)
        
        NotificationCenter.default.rx.notification(filterIntensityNotification).subscribe {[weak self] notification in
            guard let obj = notification.object else {return}
            self?.editInfo.filter.intensity = obj as! Float
            
        }.disposed(by: self.disposeBag)
    }
}

// collection view delegate & data source
extension TYPictureStitchController: UICollectionViewDelegate & UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TYOpration.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "oprationCellId", for: indexPath) as! TYOprationCell
        cell.text = TYOpration(rawValue: indexPath.item)?.toName()
        cell.isSelected = indexPath.item == oprationSelectedItem.rawValue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        oprationSelectedItem = TYOpration(rawValue: indexPath.item)!
    }
     
}

// 跳转操作控制器
extension TYPictureStitchController {
    private func presentOprationController(with opration: TYOpration) {

        let destinationVC : TYOprationEditController = TYProportionEditController(editInfo: editInfo)

//        switch opration {
//
//        case .proportion:
//            let vc = TYProportionEditController(editInfo: editInfo)
////            vc.selectedProportion = editInfo.proportion
////            vc.itemSelectedObserver.subscribe(onNext: { [weak self] indexPath in
////                let proportionEdit = TYProportion(rawValue: indexPath.item)
////
////                if (nil != proportionEdit) {
////                    self?.editInfo.proportion = proportionEdit!
////                }
////
////                // 选中item后按照选中的比例调整updownView视图的显示
////                let radio = proportionEdit!.toRadio()
////                self?.imageEditView!.snp.remakeConstraints { make in
////                    make.center.equalToSuperview()
////                    if radio > 1 {
////                        make.width.equalToSuperview()
////                        make.height.equalToSuperview().dividedBy(radio)
////                    } else {
////                        make.height.equalToSuperview()
////                        make.width.equalToSuperview().multipliedBy(radio)
////                    }
////
////                }
////
////
////            }).disposed(by: self.disposeBag)
//            destinationVC = vc
//        case .layout: break
////            let vc = TYLayoutEditController(images: images)
////            vc.selectedLayoutEdit = editInfo.layout
////            vc.itemSelectedObserver.subscribe(onNext: {[weak self] indexPath in
////
////                let editEnum = TYLayoutEditEnum(rawValue: indexPath.item)
////                if nil != editEnum {
////                    self?.editInfo.layout = editEnum!
////                }
////
////                let imageEditView = editEnum?.toEditView(images: self?.images)
////                if let view = imageEditView {
////                    self?.imageContentView.subviews.forEach({ view in
////                        view.removeFromSuperview()
////                    })
////                    view.backgroundColor = self!.editInfo.backgroundColor.color()
////                    view.padding = CGFloat(self!.editInfo.borderCorner.pictureBorder)
////                    view.imagePandding = CGFloat(self!.editInfo.borderCorner.imageBorder)
////                    view.imageCornerRadio = CGFloat(self!.editInfo.borderCorner.imageCornerRadio)
////                    self?.imageContentView.addSubview(view)
////                    self?.imageEditView = view
////                    view.snp.makeConstraints { make in
////                        make.edges.equalToSuperview()
////                    }
////                }
////
////            }).disposed(by: self.disposeBag)
////            destinationVC = vc
//        case .border: break
////            let vc = TYBorderEditController(pictureBorderValue: editInfo.borderCorner.pictureBorder, imageBorderValue: editInfo.borderCorner.imageBorder, imageCornerRadioValue: editInfo.borderCorner.imageCornerRadio)
////
////            vc.pictureBorderObserver.subscribe(onNext: {[weak self] value in
////                self?.imageEditView?.padding = CGFloat(value)
////                self?.editInfo.borderCorner.pictureBorder = value
////            }).disposed(by: self.disposeBag)
////
////            vc.imageBorderObserver.subscribe(onNext: {[weak self] value in
////                self?.imageEditView?.imagePandding = CGFloat(value)
////                self?.editInfo.borderCorner.imageBorder = value
////            }).disposed(by: self.disposeBag)
////
////            vc.imageCornerRadioObserver.subscribe(onNext: {[weak self] value in
////                self?.imageEditView?.imageCornerRadio = CGFloat(value)
////                self?.editInfo.borderCorner.imageCornerRadio = value
////            }).disposed(by: self.disposeBag)
////
////            destinationVC = vc
//
//        case .background: break
////            let vc = TYPictureBackgroundEditController()
////            vc.selectedColor = editInfo.backgroundColor
////            vc.itemSelectedObserver.subscribe(onNext: {[weak self] indexPath in
////                let colorEnum = TYBackgroundColorEnum(rawValue: indexPath.item)!
////                self?.editInfo.backgroundColor = colorEnum
////                self?.imageEditView!.backgroundColor = colorEnum.color()
////            }).disposed(by: self.disposeBag)
////            destinationVC = vc
//
//        case .filter: break
//
////            let vc = TYFilterEditController(with: editInfo.filter)
////            destinationVC = vc
//
//        case .texture: break
////            destinationVC = TYOprationEditController()
//
//        case .text: break
//
////            let vc = TYTextEditController()
////            vc.textObserver.subscribe(onNext: {text in
////                print(text ?? "哈哈")
////                guard let t = text else { return }
////                // 将文字添加到文字贴纸上
////                let textStickerView = TYTextStickerView(text: t)
////                textStickerView.width = 150
////                textStickerView.height = 44
////                textStickerView.center = self.imageEditView!.center
////                self.imageEditView?.addSubview(textStickerView)
////
////            }).disposed(by: self.disposeBag)
////            destinationVC = vc
//
//        case .sticker: break
//
////            let vc = TYStickerEditController()
////            vc.itemObserver.subscribe(onNext: {name in
////
////                let stickView = TYImageStickerView()
////                stickView.width = 150
////                stickView.height = 100
////                stickView.centerX = self.imageEditView?.centerX ?? 0
////                stickView.centerY = self.imageEditView?.centerY ?? 0
////                stickView.imageName = name
////                self.imageEditView?.addSubview(stickView)
////                self.stickerNames.append(name)
////            }).disposed(by: self.disposeBag)
////            destinationVC = vc
//
//        case .pictureFrame: break
////            print("present pictureFrame controller")
////            let vc = TYPictureFrameEditController()
////            vc.pictureFrameObserver.subscribe(onNext: {[weak self] frameName in
////                self?.imageEditView?.frameImage = UIImage(named: frameName!)
////            }).disposed(by: self.disposeBag)
////            destinationVC = vc
//
//        case .addImage: break
////            destinationVC = TYOprationEditController()
//        }
        destinationVC.editView = editView
        destinationVC.transitioningDelegate = self
        destinationVC.modalPresentationStyle = .fullScreen
        destinationVC.dismissViewClosure = { view, editInfo in
            self.editInfo = editInfo
            if let contentView = view {
                self.editView = contentView as! TYBaseEditView
                self.view.addSubview(contentView)
            }

            self.alertView.snp.updateConstraints { make in
                make.bottom.equalTo(0)
            }
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        }

        alertView.snp.updateConstraints { make in
            make.bottom.equalTo(100)
        }
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
        present(destinationVC, animated: true, completion: nil)

    }
}

extension TYPictureStitchController : UIViewControllerTransitioningDelegate {
    // MARK: - UIViewControllerTransitioningDelegate

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomTransitionAnimator(sourceView: self.editView, isPresenting: true)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomTransitionAnimator(sourceView: self.editView, isPresenting: false)
    }
}
