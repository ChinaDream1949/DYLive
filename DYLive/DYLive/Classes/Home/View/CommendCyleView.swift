//
//  CommendCyleView.swift
//  DYLive
//
//  Created by MR.Sahw on 2020/9/25.
//

import UIKit

private let kCycleCellID = "kCycleCellID"

class CommendCyleView: UIView {
    var cycleTime : Timer? // 定时器
    
    var cycleModels : [CycleModel]?{
        didSet{
            collcetionView.reloadData()
            pageControlView.numberOfPages = cycleModels?.count ?? 0
            // 默认滚动到中间位置
            let indexPat = NSIndexPath(item: (cycleModels?.count ?? 0) * 100 + 1, section: 0)
            collcetionView.scrollToItem(at: indexPat as IndexPath, at: .left, animated: false)
            // 添加定时器
            removeCycleTimer()
            addCycleTimer()
        }
    }
    
    
    @IBOutlet weak var collcetionView: UICollectionView!
    @IBOutlet weak var pageControlView: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置该控件不随着父控件拉伸而拉伸
        autoresizingMask = []
        
        collcetionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        // 这里的尺寸才是正确的
        // 设置布局
        let layout = collcetionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collcetionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collcetionView.isPagingEnabled = true
    }
}

extension CommendCyleView {
    class func recommedCycleView() -> CommendCyleView {
        return Bundle.main.loadNibNamed("CommendCyleView", owner: nil, options: nil)?.first as! CommendCyleView
    }
}

extension CommendCyleView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 10000 // cycleModels? 为可选列 所以添加 ？？ 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionCycleCell
        cell.cycleModel = cycleModels![indexPath.item % cycleModels!.count]
        return cell
    }
}

extension CommendCyleView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 获取滚动的偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        // 计算pagecontrol的index
        pageControlView.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
        
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}

// 对定时器操作
extension CommendCyleView {
    private func addCycleTimer() {
        cycleTime = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTime!, forMode: .common)
    }
    private func removeCycleTimer() {
        cycleTime?.invalidate()
        cycleTime = nil
    }
    @objc private func scrollToNext() {
        // 获取滚动偏移量
        let currentOffsetX = collcetionView.contentOffset.x
        let offsetX = currentOffsetX + collcetionView.bounds.width
        // 滚动该位置
        collcetionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}
