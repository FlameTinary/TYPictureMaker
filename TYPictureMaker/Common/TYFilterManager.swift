//
//  TYFilterManager.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/6/4.
//

import CoreImage
import UIKit

class TYFilterManager {
    static let shared = TYFilterManager()

    private let context: CIContext

    private init() {
        // 在初始化方法中创建CIContext对象
        self.context = CIContext(options: nil)
    }
    
    // 应用滤镜并获取输出图像
    private func applyFilter(filter: CIFilter?) -> UIImage? {
        guard let filter = filter,
              let outputImage = filter.outputImage,
              let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else {
            return nil
        }

        let filteredImage = UIImage(cgImage: cgImage)
        return filteredImage
    }
    
}

// 组合滤镜，输出效果图片
extension TYFilterManager {
    
    // 老照片滤镜
    func applyOldFilter(to image: UIImage) -> UIImage? {

//        return applyFilter(filter: vignetteTone(to: sepiaTone(to: CIImage(image: image), intensity: 0.8)?.outputImage, intensity: 3.0, radius: 1.5))
        guard let ciImage = CIImage(image: image) else {
                return nil
            }
            
            // 创建滤镜链
            let filterChain = [
                "CISepiaTone": 0.8,
                "CIVignette": 3.0,
                "CIUnsharpMask": 1.0
            ]
            
            var outputImage = ciImage
            
            // 依次应用滤镜链中的滤镜
            for (filterName, filterValue) in filterChain {
                guard let filter = CIFilter(name: filterName) else {
                    continue
                }
                
                filter.setValue(outputImage, forKey: kCIInputImageKey)
                filter.setValue(filterValue, forKey: kCIInputIntensityKey)
                
                if let filteredImage = filter.outputImage {
                    outputImage = filteredImage
                }
            }
            
            // 将CIImage转换为UIImage
            guard let finalImage = context.createCGImage(outputImage, from: outputImage.extent) else {
                return nil
            }
            print("applyOldFilter")
            return UIImage(cgImage: finalImage)
    }
    
}

// MARK: 单一滤镜效果，直接输出效果图片
extension TYFilterManager {
    // 添加高斯模糊滤镜
    func applyGaussianBlur(to image: UIImage, radius: CGFloat) -> UIImage? {
        
        return applyFilter(filter: gaussianBlur(to: CIImage(image: image), radius: radius))
        
    }

    // 添加锐化滤镜
    func applySharpen(to image: UIImage, intensity: CGFloat) -> UIImage? {
  
        return applyFilter(filter: sharpen(to: CIImage(image: image), intensity: intensity))
        
    }

    // 添加黑白滤镜
    func applyBlackAndWhite(to image: UIImage) -> UIImage? {
        
        return applyFilter(filter: blackAndWhite(to: CIImage(image: image)))
    }

    // 添加色调滤镜
    func applyHueAdjustment(to image: UIImage, angle: CGFloat) -> UIImage? {

        return applyFilter(filter: hueAdjustment(to: CIImage(image: image), angle: angle))
    }

    // 添加饱和度滤镜
    func applySaturationAdjustment(to image: UIImage, saturation: CGFloat) -> UIImage? {

        return applyFilter(filter: saturationAdjustment(to: CIImage(image: image), saturation: saturation))
    }

    // 添加亮度滤镜
    func applyBrightnessAdjustment(to image: UIImage, brightness: CGFloat) -> UIImage? {

        return applyFilter(filter: brightnessAdjustment(to: CIImage(image: image), brightness: brightness))
    }

    // 添加对比度滤镜
    func applyContrastAdjustment(to image: UIImage, contrast: CGFloat) -> UIImage? {
        
        return applyFilter(filter: contrastAdjustment(to: CIImage(image: image), contrast: contrast))
    }

    // 添加曝光滤镜
    func applyExposureAdjustment(to image: UIImage, exposure: CGFloat) -> UIImage? {
        
        return applyFilter(filter: exposureAdjustment(to: CIImage(image: image), exposure: exposure))
    }

    // 添加褪色滤镜
    func applyFade(to image: UIImage, intensity: CGFloat) -> UIImage? {
        return applyFilter(filter: fade(to: CIImage(image: image), intensity: intensity))
    }

    // 添加怀旧滤镜
    func applySepiaTone(to image: UIImage, intensity: CGFloat) -> UIImage? {
        return applyFilter(filter: sepiaTone(to: CIImage(image: image), intensity: intensity))
    }
    
    // 添加暗角滤镜
    func applyVignetteTone(to image: UIImage, intensity: CGFloat, radius: CGFloat) -> UIImage? {

        return applyFilter(filter: vignetteTone(to: CIImage(image: image), intensity: intensity, radius: radius))
    }

    // 添加风格化滤镜
//    func applyVibrance(to image: UIImage, vibrance: CGFloat) -> UIImage? {
//        guard let ciImage = CIImage(image: image) else {
//            return nil
//        }
//
//        let filter = CIFilter(name: "CIVibrance")
//        filter?.setValue(ciImage, forKey: kCIInputImageKey)
//        filter?.setValue(vibrance, forKey: kCIInputAmountKey)
//
//        return applyFilter(filter: filter, to: ciImage)
//    }
}

// MARK: 单一滤镜效果，用作组合滤镜效果
extension TYFilterManager {
    // 添加高斯模糊滤镜
    private func gaussianBlur(to ciImage: CIImage?, radius: CGFloat) -> CIFilter? {
        guard let ciImage = ciImage else { return nil }
        let filter = CIFilter(name: "CIGaussianBlur")
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        filter?.setValue(radius, forKey: kCIInputRadiusKey)

        return filter
    }

    // 添加锐化滤镜
    private func sharpen(to ciImage: CIImage?, intensity: CGFloat) -> CIFilter? {
        guard let ciImage = ciImage else { return nil }
        let filter = CIFilter(name: "CISharpenLuminance")
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        filter?.setValue(intensity, forKey: kCIInputSharpnessKey)

        return filter
    }

    // 添加黑白滤镜
    private func blackAndWhite(to ciImage: CIImage?) -> CIFilter? {
        guard let ciImage = ciImage else { return nil }
        let filter = CIFilter(name: "CIPhotoEffectNoir")
        filter?.setValue(ciImage, forKey: kCIInputImageKey)

        return filter
    }

    // 添加色调滤镜
    private func hueAdjustment(to ciImage: CIImage?, angle: CGFloat) -> CIFilter? {
        guard let ciImage = ciImage else { return nil }
        let filter = CIFilter(name: "CIHueAdjust")
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        filter?.setValue(angle, forKey: kCIInputAngleKey)

        return filter
    }

    // 添加饱和度滤镜
    private func saturationAdjustment(to ciImage: CIImage?, saturation: CGFloat) -> CIFilter? {
        guard let ciImage = ciImage else { return nil }
        let filter = CIFilter(name: "CIColorControls")
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        filter?.setValue(saturation, forKey: kCIInputSaturationKey)

        return filter
    }

    // 添加亮度滤镜
    private func brightnessAdjustment(to ciImage: CIImage?, brightness: CGFloat) -> CIFilter? {
        guard let ciImage = ciImage else { return nil }
        let filter = CIFilter(name: "CIColorControls")
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        filter?.setValue(brightness, forKey: kCIInputBrightnessKey)

        return filter
    }

    // 添加对比度滤镜
    private func contrastAdjustment(to ciImage: CIImage?, contrast: CGFloat) -> CIFilter? {
        guard let ciImage = ciImage else { return nil }
        let filter = CIFilter(name: "CIColorControls")
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        filter?.setValue(contrast, forKey: kCIInputContrastKey)

        return filter
    }

    // 添加曝光滤镜
    private func exposureAdjustment(to ciImage: CIImage?, exposure: CGFloat) -> CIFilter? {
        guard let ciImage = ciImage else { return nil }
        let filter = CIFilter(name: "CIExposureAdjust")
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        filter?.setValue(exposure, forKey: kCIInputEVKey)

        return filter
    }

    // 添加褪色滤镜
    private func fade(to ciImage: CIImage?, intensity: CGFloat) -> CIFilter? {
        guard let ciImage = ciImage else { return nil }
        let filter = CIFilter(name: "CIPhotoEffectFade")
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
//        filter?.setValue(intensity, forKey: kCIInputIntensityKey)

        return filter
    }

    // 添加怀旧滤镜
    private func sepiaTone(to ciImage: CIImage?, intensity: CGFloat) -> CIFilter? {
        guard let ciImage = ciImage else { return nil }
        let filter = CIFilter(name: "CISepiaTone")
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        filter?.setValue(intensity, forKey: kCIInputIntensityKey)

        return filter
    }
    
    // 添加暗角滤镜
    private func vignetteTone(to ciImage: CIImage?, intensity: CGFloat, radius: CGFloat) -> CIFilter? {
        
        guard let ciImage = ciImage else { return nil }
        
        let filter = CIFilter(name: "CIVignette")
        // 设置滤镜2的输入图像
        filter?.setValue(ciImage, forKey: kCIInputImageKey)

        // 设置滤镜2的参数：强度
        filter?.setValue(intensity, forKey: kCIInputIntensityKey)
        // 控制滤镜的半径大小
        filter?.setValue(radius, forKey: kCIInputRadiusKey)

        return filter
    }

    // 添加风格化滤镜
//    func applyVibrance(to image: UIImage, vibrance: CGFloat) -> UIImage? {
//        guard let ciImage = CIImage(image: image) else {
//            return nil
//        }
//
//        let filter = CIFilter(name: "CIVibrance")
//        filter?.setValue(ciImage, forKey: kCIInputImageKey)
//        filter?.setValue(vibrance, forKey: kCIInputAmountKey)
//
//        return applyFilter(filter: filter, to: ciImage)
//    }
}
