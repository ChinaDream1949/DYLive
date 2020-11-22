//
//  DYLiveViewController.swift
//  DYLive
//
//  Created by MR.Sahw on 2020/11/22.
//

import UIKit

class DYLiveViewController: UIViewController {
    
    private lazy var amuseVM : RecommendViewModel = RecommendViewModel()
    
    private lazy var liveView : DYLiveAmuseView = {
        let menuView = DYLiveAmuseView.liveAmuseView()
        menuView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH)
        menuView.backgroundColor = UIColor.white
        if #available(iOS 11.0, *) {
            menuView.dyLiveTableView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        return menuView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.addSubview(liveView)
        
        amuseVM.requesData {
            var tempGroups = self.amuseVM.anchorGroups
            tempGroups.removeFirst()
            self.liveView.groups = tempGroups
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        self.liveView.dyLiveTableView?.layer.removeAllAnimations()
        let cells = self.liveView.dyLiveTableView?.visibleCells as! [DYVideoCell]
        for cell in cells {
            cell.playerView.pause()
        }
//        NotificationCenter.default.removeObserver(self)
//        self.removeObserver(self, forKeyPath: "currentPage")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let cells = self.liveView.dyLiveTableView?.visibleCells as! [DYVideoCell]
        for cell in cells {
            cell.playerView.play()
        }
    }
    // 电池栏颜色
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

}
