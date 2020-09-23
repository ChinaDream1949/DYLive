//
//  UIBarButtonItem-Extension.swift
//  DYLive
//
//  Created by MR.Sahw on 2020/9/23.
//

import UIKit

extension UIBarButtonItem {
    /*
    class func createItem (imageName : String, hightImage : String, size : CGSize) -> UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: hightImage), for: .highlighted)
//        historyBtn.sizeToFit()  没有间隔
        btn.frame = CGRect(origin: .zero, size: size)
        return UIBarButtonItem(customView: btn)
    }
    */
    
    // swift 一般建议使用构造函数
    // 便利构造函数 (1.必须以 convenience 开通 2.在构造函数中必须明确调用一个设计函数（self）)
    convenience init (imageName : String, hightImage : String = "", size : CGSize = .zero) {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        if hightImage != "" {
            btn.setImage(UIImage(named: hightImage), for: .highlighted)
        }
        if size == .zero {
          btn.sizeToFit()
        }else{
//        historyBtn.sizeToFit()  没有间隔
          btn.frame = CGRect(origin: .zero, size: size)
        }

        self.init(customView: btn)
    }
}
