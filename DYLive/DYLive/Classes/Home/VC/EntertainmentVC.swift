//
//  EntertainmentVC.swift
//  DYLive
//
//  Created by MR.Sahw on 2020/9/26.
//

import UIKit

private let kMenuViewH : CGFloat = 200

class EntertainmentVC: BaseAnchorViewController {
    private lazy var amuseVM : AmuseViewModel = AmuseViewModel()
    private lazy var menuView : AmuseMenuView = {
        let menuView = AmuseMenuView.amuseMenuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)
        menuView.backgroundColor = UIColor.white
        return menuView
    }()
}
// 设置UI
extension EntertainmentVC {
    override func setupUI() {
        super.setupUI()
        collectionView.addSubview(menuView)
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
    }
}
// 请求数据
extension EntertainmentVC {
    override func loadData() {
        // 1.给父类中baseVM的进行赋值
        baseVM = amuseVM
        // 2.请求数据
        amuseVM.loadAmuseData {
            self.collectionView.reloadData()
            
            var tempGroups = self.amuseVM.anchorGroups
            tempGroups.removeFirst()
            self.menuView.groups = tempGroups
            // 隐藏
            self.loadDataFinished()
        }
    }
}

