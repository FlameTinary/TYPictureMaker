//
//  TYFilterEnum.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/25.
//

import Foundation
import UIKit

enum TYFilterEnum: Int, CaseIterable {
    
    case none = 0, sepiaTone, gaussianBlur, sharpen, blackAndWhite, hueAdjustment, saturationAdjustemnt, brightnessAdjustment, contrastAdjustment, exposureAdjustment, fade, vignetteTone, old, lomo
    
    func toName() -> String {
        switch self {
        case .none:
            return "无效果"
        case .sepiaTone:
            return "怀旧"
        case .gaussianBlur:
            return "高斯模糊"
        case .sharpen:
            return "锐化"
        case .blackAndWhite:
            return "黑白"
        case .hueAdjustment:
            return "色调"
        case .saturationAdjustemnt:
            return "饱和度"
        case .brightnessAdjustment:
            return "亮度"
        case .contrastAdjustment:
            return "对比度"
        case .exposureAdjustment:
            return "曝光"
        case .fade:
            return "褪色"
        case .vignetteTone:
            return "暗角"
        case .old:
            return "老照片"
        case .lomo:
            return "lomo"
        }
        
    }
    
    func toImage(image: UIImage) -> UIImage? {
        let manager = TYFilterManager.shared
        let intensity = 0.8
        let radius = 10.0
        let angle = 0.5
        let saturation = 1.5
        let brightness = 0.3
        let contrast = 0.5
        let exposure = 0.5
        switch self {
            
        case .none:
            return image
        case .sepiaTone:
            return manager.applySepiaTone(to: image, intensity: intensity)
        case .gaussianBlur:
            return manager.applyGaussianBlur(to: image, radius: radius)
        case .sharpen:
            return manager.applySharpen(to: image, intensity: intensity)
        case .blackAndWhite:
            return manager.applyBlackAndWhite(to: image)
        case .hueAdjustment:
            return manager.applyHueAdjustment(to: image, angle: angle)
        case .saturationAdjustemnt:
            return manager.applySaturationAdjustment(to: image, saturation: saturation)
        case .brightnessAdjustment:
            return manager.applyBrightnessAdjustment(to: image, brightness: brightness)
        case .contrastAdjustment:
            return manager.applyContrastAdjustment(to: image, contrast: contrast)
        case .exposureAdjustment:
            return manager.applyExposureAdjustment(to: image, exposure: exposure)
        case .fade:
            return manager.applyFade(to: image, intensity: intensity)
        case .vignetteTone:
            return manager.applyVignetteTone(to: image, intensity: intensity, radius: radius)
        case .old:
            return manager.applyOldFilter(to: image)
        case .lomo:
            return manager.applyLomo(to: image)
        }
    }
}
