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
    
    // filter
    private let context = CIContext(options: nil)
    private var filter : CIFilter?
    private var orientation = UIImage.Orientation.up
    
    // cell id
    private let cellId = "filterCellId"

    private lazy var filterScrollView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: 100, height: 30)

        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .clear
        view.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 10, right: 5)
        view.register(TYOprationCell.self, forCellWithReuseIdentifier: cellId)
        view.dataSource = self
        view.delegate = self
        view.selectItem(at: IndexPath(item: editInfo.filter.filter.rawValue, section: 0), animated: true, scrollPosition: .top)
        
        _ = view.rx.itemSelected.asObservable().takeUntil(rx.deallocated).subscribe(onNext: { [weak self] indexPath in
            let filter = TYFilterEnum(rawValue: indexPath.item)!
            self?.editInfo.filter.filter = filter
            
            //TODO: 通过选择不同的filter，生成不同的滤镜效果
            
            
        })
        
        return view
    }()

    private lazy var intensitySlider : UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1.0
        slider.value = editInfo.filter.intensity
        _ = slider.rx.value.asObservable().takeUntil(rx.deallocated).subscribe(onNext: { [weak self] value in
            self?.editInfo.filter.intensity = value
            
            //TODO: 通过更改intensity的值，来改变当前滤镜的intensity值
            
        })
        return slider
    }()

    override func setupSubviews() {
        super.setupSubviews()
        alertView.addSubview(filterScrollView)
        alertView.addSubview(intensitySlider)

        filterScrollView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(28)
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
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


extension TYFilterEditController {
    
    func applySepiaFilter(intensity: Float) -> UIImage?{
        guard let f = filter else { return nil}
        if (f.name == "none") {return nil}
        
        f.setValue(intensity, forKey: kCIInputIntensityKey)

        guard let outputImage = f.outputImage else { return nil}

        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return nil}
        return UIImage(cgImage: cgImage, scale: 1, orientation: orientation)
    }
    
    func applyOldPhotoFilter(intensity: Float) -> UIImage? {
        guard let f = filter else { return nil}
        
        if (f.name == "none") {return nil}
            
        f.setValue(intensity, forKey: kCIInputIntensityKey)

        let random = CIFilter(name: "CIRandomGenerator")

        let lighten = CIFilter(name: "CIColorControls")
        lighten?.setValue(random?.outputImage, forKey: kCIInputImageKey)
        lighten?.setValue(1 - intensity, forKey: kCIInputBrightnessKey)
        lighten?.setValue(0, forKey: kCIInputSaturationKey)

        guard let ciImage = f.value(forKey: kCIInputImageKey) as? CIImage else { return nil}
        let croppedImage = lighten?.outputImage?.cropped(to: ciImage.extent)

        let composite = CIFilter(name: "CIHardLightBlendMode")
        composite?.setValue(f.outputImage, forKey: kCIInputImageKey)
        composite?.setValue(croppedImage, forKey: kCIInputBackgroundImageKey)

        let vignette = CIFilter(name: "CIVignette")
        vignette?.setValue(composite?.outputImage, forKey: kCIInputImageKey)
        vignette?.setValue(intensity * 2, forKey: kCIInputIntensityKey)
        vignette?.setValue(intensity * 30, forKey: kCIInputRadiusKey)

        guard let outputImage = vignette?.outputImage else { return nil}
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return nil}
        return UIImage(cgImage: cgImage, scale: 1, orientation: orientation)
    }
}
