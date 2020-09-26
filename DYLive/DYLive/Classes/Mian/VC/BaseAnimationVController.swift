//
//  BaseAnimationVController.swift
//  DYLive
//
//  Created by MR.Sahw on 2020/9/26.
//

import UIKit

class BaseAnimationVController: UIViewController {
    // 定义属性
    var contentView : UIView?
    
    // 懒加载
    fileprivate lazy var animImageView : UIImageView = {[unowned self] in
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        imageView.center = self.view.center
        imageView.animationImages  = [UIImage(named: "img_loading_1")!,UIImage(named: "img_loading_2")!]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin]
        return imageView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    

}

extension BaseAnimationVController {
    @objc func setupUI() {
        // 1.先隐藏内容view
        contentView?.isHidden = true
        // 2.显示动画
        view.addSubview(animImageView)
        // 3.执行动画
        animImageView.startAnimating()
        // 设置背景颜色
        view.backgroundColor = UIColor(r: 234, g: 234, b: 234)
    }
    func loadDataFinished() {
        animImageView.stopAnimating()
        animImageView.isHidden = true
        contentView?.isHidden = false
    }
}
