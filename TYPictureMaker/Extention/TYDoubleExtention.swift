//
//  TYDoubleExtention.swift
//  TYPictureMaker
//
//  Created by server on 2023/11/2.
//

import Foundation
extension Double {
    var scale : Double {
        get {
            let scale = TYDeviceModel().getAdaptationScale()
            return self * Double(scale)
        }
    }
}
