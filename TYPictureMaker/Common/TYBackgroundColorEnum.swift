//
//  TYBackgroundColorEnum.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/24.
//

import UIKit

enum TYBackgroundColorEnum: Int, CaseIterable {
    case white = 0, black, green, blue, brown, cyan, orange, red
    
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
