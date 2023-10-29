//
//  TYPhotoPicker.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/10/29.
//

import Foundation
import ZLPhotoBrowser
import Photos


class TYPhotoPicker {
    
    /// 打开相册
    /// - Parameters:
    ///   - sender: 当前页面控制器
    ///   - callback: 返回的图片信息内容
    static func pickImages(sender: UIViewController, callback: ( ([UIImage], [PHAsset], Bool) -> Void )?) {
        let ps = ZLPhotoPreviewSheet()
        ps.selectImageBlock = callback
        ps.showPhotoLibrary(sender: sender)
    }
        
    static func photoSave(image:UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(imageSaved(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc private static func imageSaved(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // 图片保存失败
            //            view.makeToast("保存图片到相册失败: \(error.localizedDescription)", duration: 1.0, position: .center)
        } else {
            // 图片保存成功
            //            view.makeToast("图片保存成功", duration: 1.0, position: .center)
        }
    }
    
}
