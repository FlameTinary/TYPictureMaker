//
//  TYEditViewProtocol.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/28.
//

import UIKit

protocol TYEditViewProtocol: AnyObject {
    
    // 图片集
    var images : [UIImage] { get set }
    
    // 背景图片
    var backgroundImage: UIImage? { get set }
    
    // 边框图片
    var frameImage: UIImage? { get set }
    
    // 图片间距
    var imagePandding: CGFloat { get set }
    
    // 图片圆角
    var imageCornerRadio : CGFloat { get set }
    
    // 初始化器
    init(images: [UIImage])
    
}
