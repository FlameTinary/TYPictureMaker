//
//  TYCGFloatExtention.swift
//  TYPictureMaker
//
//  Created by server on 2023/11/2.
//

import Foundation

extension CGFloat {
    var scale : CGFloat {
        get {
            let scale = TYDeviceModel().getAdaptationScale()
            return self * scale
        }
    }
}
