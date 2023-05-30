//
//  TYFilterEditController.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/25.
//

import UIKit
import RxSwift
import RxCocoa

class TYFilterEditController : TYOprationEditController {
    
    private let cellId = "filterCellId"
    
    var selectedFilter : TYFilterModel
    
    private lazy var filterScrollView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: 100, height: 30)
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .clear
        view.contentInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        view.register(TYOprationCell.self, forCellWithReuseIdentifier: cellId)
        view.dataSource = self
        view.delegate = self
        view.selectItem(at: IndexPath(item: selectedFilter.filter.rawValue, section: 0), animated: true, scrollPosition: .top)
        return view
    }()
    
    private lazy var intensitySlider : UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1.0
        slider.value = selectedFilter.intensity
        return slider
    }()
    
    init(with filterModel: TYFilterModel) {
        selectedFilter = filterModel
        super.init()
        _ = filterScrollView.rx.itemSelected.asObservable().takeUntil(self.rx.deallocated).subscribe(onNext: {indexPath in
            let notifcationName = Notification.Name("changeFilter")
            let filter = TYFilterEnum(rawValue: indexPath.item)!
            NotificationCenter.default.post(name: notifcationName, object: filter)
        })
        _ = intensitySlider.rx.value.asObservable().takeUntil(self.rx.deallocated).subscribe(onNext: {value in
            let notifcationName = Notification.Name("changeIntensity")
            NotificationCenter.default.post(name: notifcationName, object: value)
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        alertView.addSubview(filterScrollView)
        alertView.addSubview(intensitySlider)
        
        filterScrollView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.left.right.equalToSuperview()
            make.height.equalTo(100)
        }
        
        intensitySlider.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(30)
            make.top.equalTo(filterScrollView.snp_bottomMargin).offset(10)
        }
    }
    
}

extension TYFilterEditController: UICollectionViewDelegate & UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TYFilterEnum.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TYOprationCell
        cell.text = TYFilterEnum(rawValue: indexPath.item)?.toName()
        return cell
    }
    
}
