//
//  TYProportionEditController.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/24.
//

import UIKit

class TYProportionEditController : TYOprationEditController {
    
    private let cellId = "proportionCellId"

    private lazy var proportionScrollView : UICollectionView = {
        
        let itemW = 60.0.scale

        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: itemW, height: itemW*0.5)

        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .clear
        view.register(TYProportionCell.self, forCellWithReuseIdentifier: cellId)
        view.dataSource = self
        view.delegate = self
        view.selectItem(at: IndexPath(item: editInfo.proportion.rawValue, section: 0), animated: true, scrollPosition: .top)
        return view
    }()
    
    override func setupSubviews() {
        let layout = proportionScrollView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemSize = layout.itemSize
        aleartCountentHeight = itemSize.height + 16
                
        super.setupSubviews()
        alertView.addSubview(proportionScrollView)
        proportionScrollView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(-proportionScrollView.safeBottom)
        }
    }
    
}





// collection view delegate & data source
extension TYProportionEditController: UICollectionViewDelegate & UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TYProportion.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TYProportionCell
        cell.text = TYProportion(rawValue: indexPath.item)?.toName()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let proportion = TYProportion(rawValue: indexPath.item)
        editInfo.proportion = proportion!
        
        // 通过宽度计算高度
        var editViewW = view.width
        var editViewH = editInfo.proportion.heightFrom(width: editViewW)
        
        // 计算当前屏幕能容纳的最高高度
        let maxH = Double(view.height) - Double(alertView.height) - 150
        
        if editViewH > maxH {
            // 超过了屏幕能容纳的最大高度
            editViewH = maxH
            editViewW = editInfo.proportion.widthFrom(height: maxH)
        }
        
        UIView.animate(withDuration: 0.25, delay: 0, options: [.overrideInheritedDuration, .overrideInheritedOptions, .layoutSubviews]) {
            self.editView.size = CGSize(width: editViewW, height: editViewH)
            self.editView.centerX = self.view.centerX
            self.editView.centerY = self.view.centerY - 50
        }
        
    }
     
}
