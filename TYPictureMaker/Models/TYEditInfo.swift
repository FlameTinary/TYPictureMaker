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
    
    init(images: [UIImage]) {
        self.images = images
    }
    init (){}
}
