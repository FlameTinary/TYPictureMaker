//
//  File.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/6/4.
//

import UIKit

class TYNinePiecesController: UIViewController {
    var collectionView: UICollectionView!
    
    var images: [UIImage] = [] // 存储分割后的图片
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 分割图片，并将结果存储在 images 数组中
        guard let originalImage = UIImage(named: "image_01") else {
            return
        }
        images = splitImageIntoNinePieces(image: originalImage) ?? []
        
        let imgW = originalImage.size.width
        let imgH = originalImage.size.height
        let radio = imgW / imgH
        
        // 间距
        let space = 1.0
        
        // 一行3个
        let lineItem = 3.0
        
        let itemW = (view.width - (space * 3)) / lineItem
        let itemH = itemW / radio
        
        // 创建 UICollectionViewFlowLayout 布局
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: itemW, height: itemH) // 设置每个单元格的大小
        layout.minimumInteritemSpacing = space // 设置水平间距
        layout.minimumLineSpacing = space // 设置垂直间距
        
        // 创建 UICollectionView，并将布局和 frame 设置为适当的值
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        
        // 注册自定义的单元格类
        collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        // 设置数据源
        collectionView.dataSource = self
        
        // 添加 UICollectionView 到视图中
        view.addSubview(collectionView)
        
        // 刷新 UICollectionView
        collectionView.reloadData()
    }
}

extension TYNinePiecesController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MyCollectionViewCell
        
        // 在每个单元格中显示相应的图片
        let image = images[indexPath.item]
        cell.imageView.image = image
        
        return cell
    }
}

extension TYNinePiecesController {
    func splitImageIntoNinePieces(image: UIImage) -> [UIImage]? {
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


