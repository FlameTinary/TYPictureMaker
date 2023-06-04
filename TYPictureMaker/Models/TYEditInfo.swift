//
//  TYEditInfo.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/22.
//

import UIKit

class TYEditInfo {
    var images: [UIImage] = []
    
    var filterImages : [UIImage] {
        get {
            var filterImages : [UIImage] = []
            images.forEach { image in
                if let filterImage = filter.toImage(image: image) {
                    filterImages.append(filterImage)
                }
            }
            
            return filterImages
        }
    }
    var proportion: TYProportion = .oneToOne
    var borderCorner: TYBorderCornerModel = TYBorderCornerModel()
    
    var backgroundColor : TYBackgroundColorEnum = .white
    var backgroundImage : UIImage?
    
    var layout : TYLayoutEditEnum = .vertical
    
    var filter : TYFilterEnum = .none

    // 贴纸数组
    var stickerNames: [String] = []
    
    // 相框名称
    var frameName : String?

    init(images: [UIImage]) {
        self.images = images
    }
    init (){}
}
