//
//  TYLayoutEditEnum.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/24.
//

import UIKit

enum TYLayoutEditEnum: Int, CaseIterable {
    case vertical = 0, horizontal, view21, view22
    
    func iconNameFromEnum() -> String {
        switch self {
        case .vertical:
            return "icon_2_2"
        case .horizontal:
            return "icon_2_1"
        case .view21:
            return "icon_2_4"
        default:
            return "icon_2_1"
        }
    }
    
    func toEditView(images: [UIImage]?) -> TYBaseEditView {
        var view : TYBaseEditView
        switch self {
            
        case .vertical:
            let v = TYNormalLayoutView(images: images)
            v.axis = .vertical
            view = v
        case .horizontal:
            let v = TYNormalLayoutView(images: images)
            v.axis = .horizontal
            view = v
        case .view21:
            let v = TYLayoutView21(images: images)
            view = v
        case .view22:
            let  v = TYLayoutView22(images: images)
            view = v
        }
        return view
    }
}
