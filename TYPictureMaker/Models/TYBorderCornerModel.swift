//
//  TYBorderCornerModel.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/23.
//

import Foundation

class TYBorderCornerModel {
    
    var imageBorder: Float = 2.0
    var pictureBorder: Float = 1.0
    var imageCornerRadio : Float = 4.0
    
    init(imageBorder: Float, pictureBorder: Float, imageCornerRadio: Float) {
        self.imageBorder = imageBorder
        self.pictureBorder = pictureBorder
        self.imageCornerRadio = imageCornerRadio
    }
    
    init() {
        
    }
    
}
