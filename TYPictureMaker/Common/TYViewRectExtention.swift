//
//  TYViewRectExtention.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/27.
//

import UIKit

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
}
