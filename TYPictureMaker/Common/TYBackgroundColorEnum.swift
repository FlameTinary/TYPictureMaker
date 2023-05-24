//
//  TYBackgroundColorEnum.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/24.
//

import UIKit

enum TYBackgroundColorEnum: Int, CaseIterable {
    case red = 0, green, blue, brown, cyan, orange, white, black
    
    func color() -> UIColor {
        switch self {
        case .red:
            return .red
        case .green:
            return .green
        case .blue:
            return .blue
        case .brown:
            return .brown
        case .cyan:
            return .cyan
        case .orange:
            return .orange
        case .white:
            return .white
        case .black:
            return .black
        }
    }
}
