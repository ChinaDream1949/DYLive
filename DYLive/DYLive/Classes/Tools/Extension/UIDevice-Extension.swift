//
//  UIDevice-Extension.swift
//  DYLive
//
//  Created by MR.Sahw on 2020/9/25.
//

import UIKit

class UIDevice_Extension: UIDevice {

}

extension UIDevice{
    public func isiPhoneXorLater() -> Bool{
        let screenHight = UIScreen.main.nativeBounds.size.height
        if  screenHight == 2436 || screenHight == 1792 || screenHight == 2688 || screenHight == 1624 || screenHight == 2532 || screenHight == 2778 {
            return true
        }
        return false
    }
}
