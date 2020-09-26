//
//  CustomNavgationController.swift
//  DYLive
//
//  Created by MR.Sahw on 2020/9/26.
//

import UIKit

class CustomNavgationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 1.获取系统pop手势
        guard let systemGes = interactivePopGestureRecognizer else { return }
        // 2.获取手势添加在view中
        guard let gesView = systemGes.view else { return }
        // 3.获取target/action
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let tagetObjc = targets?.first else { return }
        
        guard let target = tagetObjc.value(forKey: "target") else { return }
        let action = Selector(("handleNavigationTransition:"))

        // 4.创建自己的手势
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        panGes.addTarget(target, action: action)
        
        
        
//        // 3.1 利用运行时机制查看所以属性名称
//        var count : UInt32 = 0
//        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)
//        for i in 0..<count {
//            let ivar = ivars![Int(i)]
//            let name = ivar_getName(ivar)
//            print(String(name)!)
//        }
    }
    

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        // 1.隐藏push的控制器的tabbar
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: animated)
    }
}
