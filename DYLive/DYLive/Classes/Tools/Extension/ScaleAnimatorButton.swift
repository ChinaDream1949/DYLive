//
//  ScaleAnimatorButton.swift
//  DYLive
//
//  Created by MR.Sahw on 2020/11/22.
//

import UIKit

class ScaleAnimatorButton: UIButton {
    // 当view本身被添加到父视图之上时
    override func willMove(toWindow newWindow: UIWindow?) {
        // 添加点击事件
        addTarget(self, action: #selector(toggleSelected), for: .touchUpInside)
    }
    @objc func toggleSelected() {
        isSelected.toggle()
    }
    
    override var isSelected: Bool {
        get {
            super.isSelected
        }
        set {
            super.transform = .init(scaleX: 0.8, y: 0.8)
            // 弹性
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1, options: [.beginFromCurrentState,.transitionCrossDissolve]) {
                super.isSelected = newValue
                super.transform = .identity
            }
        }
    }
}
