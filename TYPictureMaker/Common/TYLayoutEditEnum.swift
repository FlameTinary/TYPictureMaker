//
//  TYLayoutEditEnum.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/24.
//

import UIKit

enum TYLayoutEditEnum: Int, CaseIterable {
    case vertical = 0, horizontal, view21, view22, view23, view24, view24_1, view25
    
    // 通过枚举返回icon名称
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
    
    // 通过枚举类型返回布局视图
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
        case .view23:
            let  v = TYLayoutView23(images: images)
            view = v
        case .view24:
            let  v = TYLayoutView24(images: images)
            v.axis = .vertical
            view = v
        case .view24_1:
            let  v = TYLayoutView24(images: images)
            v.axis = .horizontal
            view = v
        case .view25:
            let  v = TYLayoutView25(images: images)
            view = v
        }
        
        return view
    }
    
    // 返回该枚举类型支持的操作
    func supportOpration() -> [TYOpration] {
        switch self {
        
        case .vertical:
            return TYOpration.allCases
        case .horizontal:
            return TYOpration.allCases
        case .view21:
            return TYOpration.allCases
        case .view22:
            return TYOpration.allCases
        case .view23:
            return TYOpration.allCases
        case .view24:
            return [.layout, .border, .background, .filter, .text, .sticker, .pictureFrame, .addImage]
        case .view24_1:
            return TYOpration.allCases
        case .view25:
            return [.layout, .background, .filter, .text, .sticker, .pictureFrame, .addImage]
        }
    }
    
}
