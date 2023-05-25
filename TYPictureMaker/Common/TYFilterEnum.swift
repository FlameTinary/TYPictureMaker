//
//  TYFilterEnum.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/25.
//

import Foundation

enum TYFilterEnum: Int, CaseIterable {
    case none = 0, sepiaTone
    
    func toName() -> String {
        switch self {
        case .none:
            return "无效果"
        case .sepiaTone:
            return "褐色调"
        }
        
    }
    
    func toCIFilterName() -> String {
        switch self {
        case .none:
            return ""
        case .sepiaTone:
            return "CISepiaTone"
        }
        
    }
}
