//
//  TYViewControllerExtention.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/10/29.
//

import UIKit
import ZLPhotoBrowser
import Photos


extension UIViewController {
    /// 打开相册
    /// - Parameters:
    ///   - sender: 当前页面控制器
    ///   - callback: 返回的图片信息内容
    func pickImages(callback: ( ([UIImage], [PHAsset], Bool) -> Void )?) {
        let ps = ZLPhotoPreviewSheet()
        ps.selectImageBlock = callback
        ps.showPreview(animate: true, sender: self)
    }
    
    
    /// 保存图片到相册
    /// - Parameter image: 需要保存的图片
    func photoSave(image:UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(imageSaved(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc private func imageSaved(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // 图片保存失败
            view.showToast("保存图片到相册失败: \(error.localizedDescription)")
        } else {
            // 图片保存成功
            view.showToast("图片保存成功")
        }
    }
    
}
