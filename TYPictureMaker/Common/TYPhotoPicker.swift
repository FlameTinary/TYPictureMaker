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
    
    static func pickImages(sender: UIViewController, callback: ( ([UIImage], [PHAsset], Bool) -> Void )?) {
        // 打开相册
        let ps = ZLPhotoPreviewSheet()
        ps.selectImageBlock = callback
//        ps.selectImageBlock = { results, isOriginal, isSuccess in
//
//            
//
//        }
        ps.showPhotoLibrary(sender: sender)
    }
}
