//
//  HomeViewController.swift
//  DYLive
//
//  Created by MR.Sahw on 2020/9/23.
//

import UIKit

private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {
    // MARK: - 懒加载属性
    private lazy var pageTitleView : PageTitleView = {
        let titleFrame = CGRect(x: 0, y: kStatusBarH+kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.backgroundColor = UIColor.white
        titleView.delegate = self
        return titleView
    }()
    
    private lazy var pageContentV : PageComtentView = {[weak self] in
        // 1.确定内容frame
        let contenH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - kTbabbarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contenH)
        // 2.确定所以子控制器
        var childVcs = [UIViewController]()
        childVcs.append(ReCommendVC())
        childVcs.append(GameVController())
        childVcs.append(EntertainmentVC())
        childVcs.append(FunToPlayVC())
    
        let contentV = PageComtentView(frame: contentFrame, childVC: childVcs, parentViewController: self)
        contentV.delegate = self
        return contentV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 0. 不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        setupUI()
    }

}

// 利用 extension 单独模块化 防止 viewDidLoad 代码臃肿、混乱

// 设置UI界面
extension HomeViewController {
    private func setupUI() {
        // 1.设置导航栏
        setupNavigationBar()
        // 2.添加titleView
        view.addSubview(pageTitleView)
        // 3.添加ContentV
        view.addSubview(pageContentV)
        pageContentV.backgroundColor = UIColor.purple
    }
    
    private func setupNavigationBar() {
        // 左侧
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo", hightImage: "", size: .zero);
        // 右侧
        let size = CGSize(width: 40, height: 40)
                
        let historyItem = UIBarButtonItem(imageName: "image_my_history", hightImage: "Image_my_history_click", size: size);
        
        let searchItem = UIBarButtonItem(imageName: "btn_search", hightImage: "btn_search_clicked", size: size);

        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", hightImage: "Image_scan_click", size: size);
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
    }
}

// 遵守 PageTitleViewDelegate 协议
extension HomeViewController : PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentV.setCurrentIndex(currentInex: index)
    }
}
// 遵守 PageTitleViewDelegate 协议
extension HomeViewController : PageComtentViewDelegate {
    func pageContentView(contentView: PageComtentView, progress: CGFloat, soureIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, soureIndex: soureIndex, targetIndex: targetIndex)
    }
}
