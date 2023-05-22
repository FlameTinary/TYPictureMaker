//
//  TYProportionEnum.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/22.
//

import Foundation

enum TYProportion: Int,CaseIterable  {
case oneToOne = 0, fourToFive, twoToOne, fourToThree, TwoToThree, nineToSixTeen, sixTeenToNine
    
    // 比例名称
    func toName() -> String {
        switch self {
        case .oneToOne:
            return "1:1"
        case .fourToFive:
            return "4:5"
        case .twoToOne:
            return "2:1"
        case .fourToThree:
            return "4:3"
        case .TwoToThree:
            return "2:3"
        case .nineToSixTeen:
            return "9:16"
        case .sixTeenToNine:
            return "16:9"
        }
    }
    
    // 宽高比系数
    func toRadio() -> Double {
        switch self {
        case .oneToOne:
            return 1.0
        case .fourToFive:
            return 0.8
        case .twoToOne:
            return 2.0
        case .fourToThree:
            return 1.3333
        case .TwoToThree:
            return 0.6667
        case .nineToSixTeen:
            return 0.5625
        case .sixTeenToNine:
            return 1.7778
        }
    }
    
    // 已知宽，得高
    func heightFrom(width: Double) -> Double {
        let radio = self.toRadio()
        return width / radio
    }
    // 已知高，得宽
    func widthFrom(height: Double) -> Double {
        let radio = self.toRadio()
        return height * radio
    }
}
