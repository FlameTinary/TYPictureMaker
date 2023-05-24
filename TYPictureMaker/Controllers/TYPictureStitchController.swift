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

class TYPictureStitchController: TYBaseViewController {
    
    var images : [UIImage]
    
    private var editInfo : TYEditInfo!
    
    private var disposeBag = DisposeBag()
    
    // 操作item选中row
    private var oprationSelectedItem: TYOpration = .proportion {
        didSet {
            presentOprationController(with: oprationSelectedItem)
        }
    }
    
    // 图片展示底视图，用于约束图片展示视图不超过屏幕
    private lazy var bgView : UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .black
        view.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(-50)
            make.width.equalToSuperview()
            make.height.equalTo(bgView.snp.width)
        }
        return bgView
    }()
    
    // 图片展示视图
    private var updownView :TYNormalLayoutView?
    
    private var heightConstraint : Constraint?
    
    // 底部操作列表
    private lazy var oprationListView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.tag = 2
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(TYOprationCell.self, forCellWithReuseIdentifier: "oprationCellId")
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

    init(images: [UIImage]) {
        self.images = images
        editInfo = TYEditInfo(images: images)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.disposeBag = DisposeBag()
    }
    
    override func setupSubviews() {
        let updownView = TYNormalLayoutView(images: images)
        switch editInfo.layout {
            
        case .vertical:
            updownView.axis = .vertical
        case .horizontal:
            updownView.axis = .horizontal
        }
        updownView.pandding = CGFloat(editInfo.borderCorner.pictureBorder)
        updownView.imagePandding = CGFloat(editInfo.borderCorner.imageBorder)
        updownView.imageCornerRadio = CGFloat(editInfo.borderCorner.imageCornerRadio)
        bgView.addSubview(updownView)
        self.updownView = updownView
        // 按照默认选中的显示比例调整视图
        updownView.snp.makeConstraints { make in
            make.edges.equalTo(bgView)
        }
        
        // 操作列表
        // 进入页面默认选中第一个
        oprationListView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .top)
        oprationListView.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.left.right.equalTo(0)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
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

extension TYPictureStitchController {
    // 跳转操作控制器
    func presentOprationController(with opration: TYOpration) {
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
                self?.updownView!.snp.remakeConstraints { make in
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
                    self?.updownView?.axis = .vertical
                case .horizontal:
                    self?.updownView?.axis = .horizontal
                case .none:
                    self?.updownView?.axis = .vertical
                }
                
            }).disposed(by: self.disposeBag)
            present(vc, animated: true)
        case .border:
            do {
                print("present border controller")
                let vc = TYBorderEditController(pictureBorderValue: editInfo.borderCorner.pictureBorder, imageBorderValue: editInfo.borderCorner.imageBorder, imageCornerRadioValue: editInfo.borderCorner.imageCornerRadio)
                
                vc.pictureBorderObserver.subscribe(onNext: {[weak self] value in
                    self?.updownView?.pandding = CGFloat(value)
                    self?.editInfo.borderCorner.pictureBorder = value
                }).disposed(by: self.disposeBag)

                vc.imageBorderObserver.subscribe(onNext: {[weak self] value in
                    self?.updownView?.imagePandding = CGFloat(value)
                    self?.editInfo.borderCorner.imageBorder = value
                }).disposed(by: self.disposeBag)

                vc.imageCornerRadioObserver.subscribe(onNext: {[weak self] value in
                    self?.updownView?.imageCornerRadio = CGFloat(value)
                    self?.editInfo.borderCorner.imageCornerRadio = value
                }).disposed(by: self.disposeBag)
                
                self.present(vc, animated: true)
            }
            
        case .background:
            print("present background controller")
        case .filter:
            print("present filter controller")
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

extension TYPictureStitchController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 30)
    }
}
