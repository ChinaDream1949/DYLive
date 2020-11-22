//
//  UIHelper.swift
//  DYLive
//
//  Created by MR.Sahw on 2020/11/22.
//

import UIKit

extension UIView {
    @IBInspectable public var cornerRadius : CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
             layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable public var borderWidth : CGFloat {
        get {
            return layer.borderWidth
        }
        set {
             layer.borderWidth = newValue
        }
    }
    
    @IBInspectable public var borderCorlor : UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
             layer.borderColor = newValue.cgColor
        }
    }
    
}
