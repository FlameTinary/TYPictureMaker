//
//  TYFilterEditController.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/25.
//

import UIKit
//import RxSwift
//import RxCocoa

class TYFilterEditController : TYOprationEditController {
    
    private let filterManager = TYFilterManager.shared
    
//    private var filterImages : [UIImage] = []
    
    // cell id
    private let cellId = "filterCellId"

    private lazy var filterScrollView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 60, height: 80)

        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .clear
        view.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 10, right: 5)
        view.register(TYImageAndTextCell.self, forCellWithReuseIdentifier: cellId)
        view.dataSource = self
        view.delegate = self
        view.selectItem(at: IndexPath(item: editInfo.filter.rawValue, section: 0), animated: true, scrollPosition: .top)
        
        return view
    }()

//    private lazy var intensitySlider : UISlider = {
//        let slider = UISlider()
//        slider.minimumValue = 0
//        slider.maximumValue = 1.0
//        slider.value = editInfo.filter
//        _ = slider.rx.value.asObservable().takeUntil(rx.deallocated).subscribe(onNext: { [weak self] value in
//            self?.editInfo.filter.intensity = value
//
//            //TODO: 通过更改intensity的值，来改变当前滤镜的intensity值
//
//        })
//        return slider
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupFilterImages()
        
    }

    override func setupSubviews() {
        aleatHeight = 130
        super.setupSubviews()
        alertView.addSubview(filterScrollView)
//        alertView.addSubview(intensitySlider)

        filterScrollView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(28)
            make.left.right.equalToSuperview()
            if filterScrollView.safeBottom == 0 {
                make.bottom.equalTo(-20)
            }else {
                make.bottom.equalTo(-filterScrollView.safeBottom)
            }
        }

//        intensitySlider.snp.makeConstraints { make in
//            make.left.right.equalToSuperview()
//            make.height.equalTo(30)
//            make.top.equalTo(filterScrollView.snp_bottomMargin).offset(10)
//        }
    }
    
//    private func setupFilterImages(){
//        guard let image = UIImage(named: "image_02") else {return}
//        TYFilterEnum.allCases.forEach { filter in
//            if let image = filter.toImage(image: image) {
//                filterImages.append(image)
//            }
//        }
//        filterScrollView.reloadData()
//    }
    
}

extension TYFilterEditController: UICollectionViewDelegate & UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TYFilterEnum.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TYImageAndTextCell
        cell.text = TYFilterEnum(rawValue: indexPath.item)?.toName()
        DispatchQueue.global().async {
            let image = TYFilterEnum(rawValue: indexPath.item)?.toImage(image: UIImage(named: "image_02")!)
            DispatchQueue.main.async {
                cell.image = image
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let filter = TYFilterEnum(rawValue: indexPath.item)!
        
        editInfo.filter = filter
        
        editView.images = editInfo.filterImages
    }
    
}
