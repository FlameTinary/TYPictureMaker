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
    
    var images : [UIImage]
    
    // 图片编辑相关信息
    private var editInfo : TYEditInfo!
    
    // rx销毁属性
    private var disposeBag = DisposeBag()
    
    // 操作item选中row
    private var oprationSelectedItem: TYOpration = .proportion {
        didSet {
            presentOprationController(with: oprationSelectedItem)
        }
    }
    
    // 图片展示底视图，用于约束图片展示视图不超过屏幕
    private lazy var imageContentView : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    // 图片展示视图
    private var imageEditView :TYNormalLayoutView?
    
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

    init(images: [UIImage]) {
        self.images = images
        editInfo = TYEditInfo(images: images)
        super.init()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.disposeBag = DisposeBag()
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        alertView.addSubview(oprationListView)
        view.addSubview(imageContentView)
        
        let imageEditView = TYNormalLayoutView(images: images)
        imageEditView.backgroundColor = editInfo.backgroundColor.color()
        switch editInfo.layout {
            
        case .vertical:
            imageEditView.axis = .vertical
        case .horizontal:
            imageEditView.axis = .horizontal
        }
        imageEditView.pandding = CGFloat(editInfo.borderCorner.pictureBorder)
        imageEditView.imagePandding = CGFloat(editInfo.borderCorner.imageBorder)
        imageEditView.imageCornerRadio = CGFloat(editInfo.borderCorner.imageCornerRadio)
        imageContentView.addSubview(imageEditView)
        self.imageEditView = imageEditView
        
        alertView.snp.remakeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(100)
        }
        
        oprationListView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        imageContentView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(-50)
            make.width.equalToSuperview()
            make.height.equalTo(imageContentView.snp.width)
        }

        imageEditView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
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
        switch opration {

        case .proportion:
            let vc = TYProportionEditController()
            vc.selectedProportion = editInfo.proportion
            vc.itemSelectedObserver.subscribe(onNext: { [weak self] indexPath in
                let proportionEdit = TYProportion(rawValue: indexPath.item)
                
                if (nil != proportionEdit) {
                    self?.editInfo.proportion = proportionEdit!
                }
                
                // 选中item后按照选中的比例调整updownView视图的显示
                let radio = proportionEdit!.toRadio()
                self?.imageEditView!.snp.remakeConstraints { make in
                    make.center.equalToSuperview()
                    if radio > 1 {
                        make.width.equalToSuperview()
                        make.height.equalToSuperview().dividedBy(radio)
                    } else {
                        make.height.equalToSuperview()
                        make.width.equalToSuperview().multipliedBy(radio)
                    }
                    
                }
                
                
            }).disposed(by: self.disposeBag)
            present(vc, animated: true)
        case .layout:
            print("present layout controller")
            let vc = TYLayoutEditController()
            vc.selectedLayoutEdit = editInfo.layout
            vc.itemSelectedObserver.subscribe(onNext: {[weak self] indexPath in
                
                let editEnum = TYLayoutEditEnum(rawValue: indexPath.item)
                if nil != editEnum {
                    self?.editInfo.layout = editEnum!
                }
                switch editEnum {
                case .vertical:
                    self?.imageEditView?.axis = .vertical
                case .horizontal:
                    self?.imageEditView?.axis = .horizontal
                case .none:
                    self?.imageEditView?.axis = .vertical
                }
                
            }).disposed(by: self.disposeBag)
            present(vc, animated: true)
        case .border:
            do {
                print("present border controller")
                let vc = TYBorderEditController(pictureBorderValue: editInfo.borderCorner.pictureBorder, imageBorderValue: editInfo.borderCorner.imageBorder, imageCornerRadioValue: editInfo.borderCorner.imageCornerRadio)
                
                vc.pictureBorderObserver.subscribe(onNext: {[weak self] value in
                    self?.imageEditView?.pandding = CGFloat(value)
                    self?.editInfo.borderCorner.pictureBorder = value
                }).disposed(by: self.disposeBag)

                vc.imageBorderObserver.subscribe(onNext: {[weak self] value in
                    self?.imageEditView?.imagePandding = CGFloat(value)
                    self?.editInfo.borderCorner.imageBorder = value
                }).disposed(by: self.disposeBag)

                vc.imageCornerRadioObserver.subscribe(onNext: {[weak self] value in
                    self?.imageEditView?.imageCornerRadio = CGFloat(value)
                    self?.editInfo.borderCorner.imageCornerRadio = value
                }).disposed(by: self.disposeBag)
                
                self.present(vc, animated: true)
            }
            
        case .background:
            let vc = TYPictureBackgroundEditController()
            vc.selectedColor = editInfo.backgroundColor
            vc.itemSelectedObserver.subscribe(onNext: {[weak self] indexPath in
                let colorEnum = TYBackgroundColorEnum(rawValue: indexPath.item)!
                self?.editInfo.backgroundColor = colorEnum
                self?.imageEditView!.backgroundColor = colorEnum.color()
            }).disposed(by: self.disposeBag)
            self.present(vc, animated: true)
        case .filter:
            
            let vc = TYFilterEditController(with: editInfo.filter)
            self.present(vc, animated: true)
            
        case .texture:
            print("present texture controller")
        case .text:
            print("present text controller")
        case .sticker:
            print("present sticker controller")
        case .pictureFrame:
            print("present pictureFrame controller")
        case .addImage:
            print("present addImage controller")
        }
    }
}
