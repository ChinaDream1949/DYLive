//
//  Common.swift
//  DYLive
//
//  Created by MR.Sahw on 2020/9/23.
//

import UIKit

let kStatusBarH : CGFloat = {
    if UIDevice.current.isiPhoneXorLater() {
        return 24.0
    }else{
        return 0
    }
}()

let kNavigationBarH : CGFloat = {
    if UIDevice.current.isiPhoneXorLater() {
        return 68.0
    }else{
        return 64
    }
}()
let kTbabbarH : CGFloat = 44

let kScreenW : CGFloat = UIScreen.main.bounds.size.width
let kScreenH : CGFloat = UIScreen.main.bounds.size.height
let screenFrame:CGRect = UIScreen.main.bounds
let StatusBarTouchBeginNotification:String = "StatusBarTouchBeginNotification"
