//
//  TYViewRectExtention.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/27.
//

import UIKit
import Toast_Swift

extension UIView {
    
    public var left : CGFloat {
        get {
            return frame.origin.x
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    public var top : CGFloat {
        get {
            return frame.origin.y
        }
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    public var right : CGFloat {
        get {
            return left + width
        }
    }
    
    public var bottom : CGFloat {
        get {
            return top + height
        }
    }
    
    public var width : CGFloat {
        get {
            return frame.size.width
        }
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    public var height : CGFloat {
        get {
            return frame.size.height
        }
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
    public var maxX : CGFloat {
        get {
            return bounds.maxX
        }
    }
    public var midX : CGFloat {
        get {
            return bounds.midX
        }
    }
    public var minX : CGFloat {
        get {
            return bounds.minX
        }
    }
    public var maxY : CGFloat {
        get {
            return bounds.maxY
        }
    }
    public var midY : CGFloat {
        get {
            return bounds.midY
        }
    }
    public var minY : CGFloat {
        get {
            return bounds.minY
        }
    }
    
    public var centerX : CGFloat {
        get {
            return center.x
        }
        set {
            var center = self.center
            center.x = newValue
            self.center = center
        }
    }
    
    public var centerY : CGFloat {
        get {
            return center.y
        }
        set {
            var center = self.center
            center.y = newValue
            self.center = center
        }
    }
    
    public var size : CGSize {
        get {
            return CGSize(width: width, height: height)
        }
        set {
            width = newValue.width
            height = newValue.height
        }
    }
    
    public var safeTop : CGFloat {
        get {
            return UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
        }
    }
    
    public var safeBottom : CGFloat {
        get {
            return UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
        }
    }
}

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while let responder = parentResponder {
            parentResponder = responder.next
            if let viewController = responder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

extension UIView {
    public func showToast(_ text: String?) {
        makeToast(text, duration: 1.5, position: .center)
    }
}


//MARK: view 转图片
extension UIView {
    func toImage() -> UIImage {
        // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        layer.render(in: context!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

extension UIView {
    static var currentVC: UIViewController? {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        var current = delegate?.window?.rootViewController
        while (current?.presentedViewController != nil) {
            current = current?.presentedViewController
        }
        if let tabbar = current as? UITabBarController, tabbar.selectedViewController != nil {
            current = tabbar.selectedViewController
        }
        while let navi = current as? UINavigationController, navi.topViewController != nil {
            current = navi.topViewController
        }
        return current
    }
}


