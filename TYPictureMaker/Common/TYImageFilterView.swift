//
//  TYImageFilterView.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/25.
//

import UIKit

extension UIImageView {
    // 褐色调强度
    func applySepiaFilter(filter : CIFilter, intensity: Float) -> UIImage? {
        
        // 设置强度
        filter.setValue(intensity, forKey: kCIInputIntensityKey)
        
        // 获取 output image
        guard let outputImage = filter.outputImage else {return nil}
        
        // 将output image 转换为cgimage
        let context = CIContext(options: nil)
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else {return nil}
        
        // 将cgimage转换为uiimage
        let newImage = UIImage(cgImage: cgImage, scale: 1, orientation: UIImage.Orientation.up)
        
        // 替换当前的image
        image = newImage
        
        return newImage
        
    }
    
    func applyOldPhotoFilter(filter : CIFilter, intensity: Float) {
        
        guard let img = image else { return }
        
        // 将图片转为ciimage
        guard let ciImage = CIImage(image: img) else {return}
        
        // 设置filter input image
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        
        filter.setValue(intensity, forKey: kCIInputIntensityKey)

        let random = CIFilter(name: "CIRandomGenerator")

        let lighten = CIFilter(name: "CIColorControls")
        lighten?.setValue(random?.outputImage, forKey: kCIInputImageKey)
        lighten?.setValue(1 - intensity, forKey: kCIInputBrightnessKey)
        lighten?.setValue(0, forKey: kCIInputSaturationKey)

        guard let ciImage = filter.value(forKey: kCIInputImageKey) as? CIImage else { return }
        let croppedImage = lighten?.outputImage?.cropped(to: ciImage.extent)

        let composite = CIFilter(name: "CIHardLightBlendMode")
        composite?.setValue(filter.outputImage, forKey: kCIInputImageKey)
        composite?.setValue(croppedImage, forKey: kCIInputBackgroundImageKey)

        let vignette = CIFilter(name: "CIVignette")
        vignette?.setValue(composite?.outputImage, forKey: kCIInputImageKey)
        vignette?.setValue(intensity * 2, forKey: kCIInputIntensityKey)
        vignette?.setValue(intensity * 30, forKey: kCIInputRadiusKey)

        guard let outputImage = vignette?.outputImage else { return }
        guard let cgImage = CIContext(options: nil).createCGImage(outputImage, from: outputImage.extent) else { return }
        image = UIImage(cgImage: cgImage, scale: 1, orientation: UIImage.Orientation.up)
    }
}
