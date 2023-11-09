//
//  TYTemplateEditEnum.swift
//  TYPictureMaker
//
//  Created by server on 2023/11/9.
//

import UIKit

enum TYTemplateEditEnum: Int, CaseIterable {
    case template1
    
    // 通过枚举返回icon名称
//    func iconNameFromEnum() -> String {
//        switch self {
//        case .vertical:
//            return "icon_2_2"
//        case .horizontal:
//            return "icon_2_1"
//        case .view21:
//            return "icon_2_4"
//        default:
//            return "icon_2_1"
//        }
//    }
    
    // 通过枚举类型返回布局视图
    func toEditView(images: [UIImage]?) -> TYBaseEditView {
        var view : TYBaseEditView
        switch self {
            
        case .template1:
            let v = TemplateView1(images: images)
            view = v
        }
        
        return view
    }
    
    // 返回该枚举类型支持的操作
    func supportOpration() -> [TYOpration] {
        return [.filter, .sticker, .text, .addImage]
//        switch self {
//
//        case .vertical:
//            return TYOpration.allCases
//        case .horizontal:
//            return TYOpration.allCases
//        case .view21:
//            return TYOpration.allCases
//        case .view22:
//            return TYOpration.allCases
//        case .view23:
//            return TYOpration.allCases
//        case .view24:
//            return [.layout, .background, .filter, .text, .sticker, .pictureFrame, .addImage]
//        case .view24_1:
//            return TYOpration.allCases
//        case .view25, .view26, .view27, .view28, .view29:
//            return [.layout, .background, .filter, .text, .sticker, .pictureFrame, .addImage]
//        }
    }
    
}
