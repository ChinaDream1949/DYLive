//
//  UIColor-Extension.swift
//  DYLive
//
//  Created by MR.Sahw on 2020/9/23.
//

import UIKit

extension UIColor {
    convenience init(r : CGFloat,g : CGFloat,b : CGFloat) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
}
