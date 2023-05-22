//
//  TYOprationEnum.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/22.
//

import Foundation

enum TYOpration: Int,CaseIterable  {
case proportion = 0, layout, border, background, filter, texture, text, sticker, pictureFrame, addImage
    
    static func oprationName(rawValue: Int) -> String {
        if let opration = TYOpration(rawValue:rawValue) {
            switch opration {
            case .proportion:
                return "比例"
            case .layout:
                return "布局"
            case .border:
                return "边框"
            case .background:
                return "背景"
            case .filter:
                return "滤镜"
            case .texture:
                return "纹理"
            case .text:
                return "文字"
            case .sticker:
                return "贴纸"
            case .pictureFrame:
                return "画框"
            case .addImage:
                return "添加照片"
            }
        }
        return ""
    }

}
