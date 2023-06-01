//
//  TYEditInfo.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/22.
//

import UIKit

class TYEditInfo {
    var images: [UIImage] = []
    var proportion: TYProportion = .oneToOne
    var borderCorner: TYBorderCornerModel = TYBorderCornerModel()
    
    var backgroundColor : TYBackgroundColorEnum = .white
    
    var layout : TYLayoutEditEnum = .vertical
    
    var filter : TYFilterModel = TYFilterModel()

    // 贴纸数组
    var stickerNames: [String] = []
    
    // 相框名称
    var frameName : String?

    init(images: [UIImage]) {
        self.images = images
    }
    init (){}
}
