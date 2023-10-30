//
//  TYDeviceModel.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/10/30.
//

import DeviceKit

class TYDeviceModel {
    
    // 获取导航栏高度
    func getNavH() -> CGFloat {
        if let window = UIApplication.shared.windows.first {
            if let navigationController = window.rootViewController as? UINavigationController {
                let navigationBarHeight = navigationController.navigationBar.frame.size.height
                print("Navigation Bar Height: \(navigationBarHeight)")
                return navigationBarHeight
            } else {
                print("Not in a navigation controller")
                return 0
            }
        }
        return 0
    }
    
    // 获取状态栏高度
    func getStatusBarH() -> CGFloat {
        if let window = UIApplication.shared.windows.first {
            let statusBarHeight = window.safeAreaInsets.top
            return statusBarHeight
        }
        return 0
    }
    
    // 获取屏幕宽度
    func getScreenWidth() -> CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    // 获取机器型号
    func getiPhoneModel() -> String {
        let device = Device.current
        
        switch device {
        case .iPhone5, .iPhone5s, .iPhone5c:
            return "iPhone 5, iPhone 5s, or iPhone 5c"
        case .iPhone6, .iPhone6s, .iPhone7, .iPhone8, .simulator(.iPhone6):
            return "iPhone 6, iPhone 6s, iPhone 7, or iPhone 8, or iPhone SE (1st generation)"
        case .iPhone6Plus, .iPhone6sPlus, .iPhone7Plus, .iPhone8Plus:
            return "iPhone 6 Plus, iPhone 6s Plus, iPhone 7 Plus, or iPhone 8 Plus"
        case .iPhoneX, .iPhoneXS, .iPhone11Pro:
            return "iPhone X, iPhone XS, iPhone 11 Pro"
        case .iPhoneXSMax, .iPhone11ProMax:
            return "iPhone XS Max, iPhone 11 Pro Max"
        case .iPhoneXR, .iPhone11:
            return "iPhone XR, iPhone 11"
        case .iPhone12, .iPhone12Pro:
            return "iPhone 12, iPhone 12 Pro"
        case .iPhone12ProMax:
            return "iPhone 12 Pro Max"
        case .iPhone12Mini:
            return "iPhone 12 Mini"
        case .iPhone13, .iPhone13Pro:
            return "iPhone 13, iPhone 13 Pro"
        case .iPhone13ProMax:
            return "iPhone 13 Pro Max"
        case .iPhone13Mini:
            return "iPhone 13 Mini"
        case .iPhone14, .iPhone14Pro:
            return "iPhone 14, iPhone 14 Pro"
        case .iPhone14ProMax:
            return "iPhone 14 Pro Max"
        case .iPhone15, .iPhone15Pro:
            return "iPhone 15, iPhone 15 Pro"
        case .iPhone15ProMax:
            return "iPhone 15 Pro Max"
        default:
            return "Unknown iPhone model"
        }
    }

//    let iPhoneModel = getiPhoneModel()
//    print("iPhone Model: \(iPhoneModel)")


    func getAdaptationScale() -> CGFloat {
        let screenWidth = getScreenWidth()
        var scale: CGFloat = 1.0
        
        switch screenWidth {
        case 320:
            // 适配 iPhone 5, 5s, 5c
            scale = 0.8
        case 375:
            // 适配 iPhone 6, 6s, 7, 8, SE (1st generation)
            scale = 1.0
        case 414:
            // 适配 iPhone 6 Plus, 6s Plus, 7 Plus, 8 Plus
            scale = 1.2
        case 360:
            // 适配 iPhone 12 Mini
            scale = 1.1
        case 390:
            // 适配 iPhone 12, 12 Pro, iPhone 13, 13 Pro
            scale = 1.15
        case 428:
            // 适配 iPhone 12 Pro Max, iPhone 13 Pro Max, iPhone 14 Pro, iPhone 15 Pro
            scale = 1.25
        case 394:
            // 适配 iPhone 14, iPhone 15
            scale = 1.16
        case 435:
            // 适配 iPhone 14 Pro Max, iPhone 15 Pro Max
            scale = 1.28
        default:
            // 默认适配，可以根据实际情况修改
            scale = 1.0
        }
        
        return scale
    }


}


