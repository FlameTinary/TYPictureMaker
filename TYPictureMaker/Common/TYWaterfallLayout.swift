//
//  TYWaterfallLayout.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/6/7.
//

import UIKit

protocol TYWaterfallLayoutDelegate: NSObjectProtocol {
    func heightForRowAtIndexPath(indexPath: IndexPath) -> CGFloat
}

class TYWaterfallLayout: UICollectionViewLayout {
    
    weak var delegate : TYWaterfallLayoutDelegate?
    
    // 定义列数和间距等属性
    var numberOfColumns: Int = 2
    var cellSpacing: CGFloat = 10
    
    // 存储每列的高度
    private var columnHeights: [CGFloat] = []
    
    // 存储每个单元格的布局属性
    private var layoutAttributes: [UICollectionViewLayoutAttributes] = []
    
    override func prepare() {
        super.prepare()
        
        // 重置列高度和布局属性
        columnHeights = Array(repeating: 0, count: numberOfColumns)
        layoutAttributes = []
        
        // 计算每个单元格的布局属性
        guard let collectionView = collectionView else { return }
        let sectionCount = collectionView.numberOfSections
        for section in 0..<sectionCount {
            let itemCount = collectionView.numberOfItems(inSection: section)
            for item in 0..<itemCount {
                let indexPath = IndexPath(item: item, section: section)
                let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                
                // 计算单元格的宽度
                let cellWidth = (collectionView.bounds.width - CGFloat(numberOfColumns - 1) * cellSpacing) / CGFloat(numberOfColumns)
                
                // 找到当前高度最小的列
                var minHeightColumnIndex = 0
                var minHeight = columnHeights[minHeightColumnIndex]
                for columnIndex in 1..<numberOfColumns {
                    if columnHeights[columnIndex] < minHeight {
                        minHeight = columnHeights[columnIndex]
                        minHeightColumnIndex = columnIndex
                    }
                }
                
                // 计算单元格的位置和高度
                let x = (cellWidth + cellSpacing) * CGFloat(minHeightColumnIndex)
                let y = minHeight
                
                // 根据需求计算每个单元格的高度
                guard let cellHeight = delegate?.heightForRowAtIndexPath(indexPath: indexPath) else { return }
//                let cellHeight = CGFloat.random(in: 50...200)
                
                // 更新列高度
                columnHeights[minHeightColumnIndex] += cellHeight + cellSpacing
                
                // 设置单元格的布局属性
                attribute.frame = CGRect(x: x, y: y, width: cellWidth, height: cellHeight)
                layoutAttributes.append(attribute)
            }
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributes.filter { $0.frame.intersects(rect) }
    }
    
    override var collectionViewContentSize: CGSize {
        // 找到最高列的高度作为集合视图的内容高度
        guard let maxHeight = columnHeights.max() else { return .zero }
        return CGSize(width: collectionView?.bounds.width ?? 0, height: maxHeight)
    }
}

