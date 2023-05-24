//
//  TYLayoutEditEnum.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/24.
//

import Foundation

enum TYLayoutEditEnum: Int, CaseIterable {
    case vertical = 0, horizontal
    
    func iconNameFromEnum() -> String {
        switch self {
        case .vertical:
            return "icon_2_2"
        case .horizontal:
            return "icon_2_1"
        }
    }
}
