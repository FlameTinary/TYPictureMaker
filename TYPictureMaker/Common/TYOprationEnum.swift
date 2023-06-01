//
//  TYOprationEnum.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/22.
//

import Foundation

enum TYOpration: Int,CaseIterable  {
case proportion = 0, layout, border, background, filter, texture, text, sticker, pictureFrame, addImage
    
    func toName() -> String {
        switch self {
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
    
    func toIcon() -> String {
        switch self {
        case .proportion:
            return "proportion"
        case .layout:
            return "layout"
        case .border:
            return "border"
        case .background:
            return "background"
        case .filter:
            return "filter"
        case .texture:
            return "filter"
        case .text:
            return "text"
        case .sticker:
            return "sticker"
        case .pictureFrame:
            return "pictureFrame"
        case .addImage:
            return "addImage"
        }
    }

}
