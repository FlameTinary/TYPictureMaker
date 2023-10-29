//
//  File.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/6/4.
//

import UIKit
//import ZLPhotoBrowser
//import RxSwift
//import RxCocoa

class TYNinePiecesController: TYBaseViewController {
    var collectionView: UICollectionView!
    
    var pieceImages: [UIImage] = [] // 存储分割后的图片
    
    private lazy var barButtonItem : UIBarButtonItem = {
        
        // 创建一个按钮
        let saveButton = UIButton(type: .custom)
        saveButton.frame = CGRect(x: 0, y: 0, width: 60, height: 30)
        saveButton.setTitle("保存", for: .normal)
        saveButton.titleLabel?.font = normalFont
        saveButton.setTitleColor(normalTextColor, for: .normal)
        saveButton.backgroundColor = UIColor(hexString: "#1296db")
        saveButton.layer.cornerRadius = 4.0
//        _ = saveButton.rx.tap.takeUntil(rx.deallocated).subscribe { [weak self] _ in
//
//            guard let self = self else {return}
//            // 保存图片到相册
//            self.pieceImages.forEach { image in
//                UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.imageSaved(_:didFinishSavingWithError:contextInfo:)), nil)
//            }
//
//        }
        
        // 创建一个自定义视图
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
        customView.backgroundColor = backgroundColor
        customView.layer.cornerRadius = 4
        customView.addSubview(saveButton)

        // 创建一个UIBarButtonItem，并将自定义视图设置为customView
        let barButtonItem = UIBarButtonItem(customView: customView)
        return barButtonItem
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        
        // 打开相册
//        let ps = ZLPhotoPreviewSheet()
//        ps.selectImageBlock = { [weak self] results, isOriginal in
//            guard let self = self,
//                  let originalImage = results.map({$0.image}).first,
//                  let images = self.splitImageIntoNinePieces(image: originalImage) else {return}
//            
//            self.pieceImages = images
//            
//            let imgW = originalImage.size.width
//            let imgH = originalImage.size.height
//            let radio = imgW / imgH
//            
//            // 间距
//            let space = 1.0
//            
//            // 一行3个
//            let lineItem = 3.0
//            
//            let itemW = (self.view.width - (space * 3)) / lineItem
//            let itemH = itemW / radio
//            
//            // 创建 UICollectionViewFlowLayout 布局
//            let layout = UICollectionViewFlowLayout()
//            layout.estimatedItemSize = CGSize(width: itemW, height: itemH) // 设置每个单元格的大小
//            layout.minimumInteritemSpacing = space // 设置水平间距
//            layout.minimumLineSpacing = space // 设置垂直间距
//            
//            // 创建 UICollectionView，并将布局和 frame 设置为适当的值
//            self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
//            self.collectionView.backgroundColor = backgroundColor
//            
//            // 注册自定义的单元格类
//            self.collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
//            
//            // 设置数据源
//            self.collectionView.dataSource = self
//            
//            // 添加 UICollectionView 到视图中
//            self.view.addSubview(self.collectionView)
//            
//            // 刷新 UICollectionView
//            self.collectionView.reloadData()
//            
//        }
//        ps.showPhotoLibrary(sender: self)
        
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        // 设置导航栏右侧按钮
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc func imageSaved(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // 图片保存失败
//            view.makeToast("保存图片到相册失败: \(error.localizedDescription)", duration: 1.0, position: .center)
        } else {
            // 图片保存成功
//            view.makeToast("图片保存成功", duration: 1.0, position: .center)
        }
    }
}

extension TYNinePiecesController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pieceImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MyCollectionViewCell
        
        // 在每个单元格中显示相应的图片
        let image = pieceImages[indexPath.item]
        cell.imageView.image = image
        
        return cell
    }
}

extension TYNinePiecesController {
    func splitImageIntoNinePieces(image: UIImage?) -> [UIImage]? {
        guard let image = image else { return nil }
        let imageWidth = image.size.width
        let imageHeight = image.size.height
        
        let pieceWidth = imageWidth / 3.0
        let pieceHeight = imageHeight / 3.0
        
        var images: [UIImage] = []
        
        for row in 0..<3 {
            for column in 0..<3 {
                let originX = pieceWidth * CGFloat(column)
                let originY = pieceHeight * CGFloat(row)
                
                let pieceRect = CGRect(x: originX, y: originY, width: pieceWidth, height: pieceHeight)
                if let cgImage = image.cgImage?.cropping(to: pieceRect) {
                    let pieceImage = UIImage(cgImage: cgImage)
                    images.append(pieceImage)
                }
            }
        }
        
        return images
    }

}

class MyCollectionViewCell: UICollectionViewCell {
    let imageView: UIImageView
    
    override init(frame: CGRect) {
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        super.init(frame: frame)
        
        addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


