//
//  PageComtentView.swift
//  DYLive
//
//  Created by MR.Sahw on 2020/9/23.
//

import UIKit

protocol PageComtentViewDelegate : class {
    func pageContentView(contentView : PageComtentView,progress : CGFloat,soureIndex : Int,targetIndex : Int)
}

private let ContentCellID = "ContentCellID"

class PageComtentView: UIView {

    // MARK: - 自定属性
    private var childVCs : [UIViewController]
    private weak var parentViewController : UIViewController?
    private var starOffsetX : CGFloat = 0;
    private var isForbidScrollDelegate : Bool = false
    weak var delegate : PageComtentViewDelegate?
    // MARK: - 懒加载属性
    private lazy var collectionView : UICollectionView = {[weak self] in
        let layOut = UICollectionViewFlowLayout()
        layOut.itemSize = (self?.bounds.size)!
        layOut.minimumLineSpacing = 0
        layOut.minimumInteritemSpacing = 0
        layOut.scrollDirection = .horizontal
        // 创建 UICollectionView
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: layOut)
        collectionV.showsHorizontalScrollIndicator = false
        collectionV.isPagingEnabled = false
        collectionV.bounces = false
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return collectionV
    }()
    // MARK: - 自定义构造函数
    init(frame : CGRect , childVC : [UIViewController] , parentViewController : UIViewController?) {
        self.childVCs = childVC
        self.parentViewController = parentViewController
        super.init(frame: frame)
        // 设置UI
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - 设置UI界面
extension PageComtentView {
    private func setupUI() {
        // 1.将所有子控自强添加到父控制器中
        for childVc in childVCs {
            parentViewController?.addChild(childVc)
        }
        // 2.添加UIcollectionView用于cell中存放控制器view
        addSubview(collectionView)
        collectionView.frame  = bounds
    }
}

// MARK: - 遵守 UICollectionView 协议
extension PageComtentView  : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVc = childVCs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
    
    
}
// MARK: - 遵守 UICollectionViewDelegate 协议
extension PageComtentView  : UICollectionViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        
        starOffsetX = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 0.判断是否是点击事件
        if isForbidScrollDelegate { return }
        // 1.定义需要数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var taggetIndex : Int = 0
        // 2.判断左滑还是右滑
        let currentOffsetX :CGFloat = scrollView.contentOffset.x
        let scrollViewW : CGFloat = scrollView.bounds.width
        if currentOffsetX > starOffsetX {
            // 左滑
            // 计算 progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX/scrollViewW)
            // 计算 sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            // 计算 taggetIndex
            taggetIndex = sourceIndex + 1
            if taggetIndex >= childVCs.count {
                taggetIndex = childVCs.count - 1
            }
            // 如果完全划过去
            if currentOffsetX - starOffsetX == scrollViewW {
                progress = 1
                taggetIndex = sourceIndex
            }
        }else{
            // 右滑
            // 计算 progress
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX/scrollViewW))
            // 计算 taggetIndex
            taggetIndex =  Int(currentOffsetX / scrollViewW)
            // 计算 sourceIndex
            sourceIndex = taggetIndex + 1
            if sourceIndex >= childVCs.count {
                sourceIndex = childVCs.count - 1
            }
        }
        // 3.将 progress、taggetIndex、sourceIndex传递给titileview
        delegate?.pageContentView(contentView: self, progress: progress, soureIndex: sourceIndex, targetIndex: taggetIndex)
    }
}
// MARK: - 对外暴露方法
extension PageComtentView {
    func setCurrentIndex(currentInex : Int) {
        // 1.记录需要禁止执行代理方法
        isForbidScrollDelegate = true
        // 2.滚动到正确位置
        let offsetX = CGFloat(currentInex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
