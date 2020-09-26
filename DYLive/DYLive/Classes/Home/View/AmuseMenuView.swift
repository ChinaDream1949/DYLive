//
//  AmuseMenuView.swift
//  DYLive
//
//  Created by MR.Sahw on 2020/9/26.
//

import UIKit

private let kAmuseMenuCellID = "kAmuseMenuCellID"

class AmuseMenuView: UIView {
    // 定义属性
    var groups : [AnchorGroup]? {
        didSet{
            colletcionView.reloadData()
        }
    }
    
    @IBOutlet weak var colletcionView: UICollectionView!
    @IBOutlet weak var pageControllView: UIPageControl!
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        colletcionView.register(UINib(nibName: "AmuseMenuViewCell", bundle: nil), forCellWithReuseIdentifier: kAmuseMenuCellID)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = colletcionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = colletcionView.bounds.size
    }
}

extension AmuseMenuView {
    class func amuseMenuView() -> AmuseMenuView{
        return Bundle.main.loadNibNamed("AmuseMenuView", owner: nil, options: nil)?.first as! AmuseMenuView
    }
}

extension AmuseMenuView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if groups == nil { return 0}
        let pageNumber = (groups?.count ?? 0 - 1)/8 + 1
        pageControllView.numberOfPages = pageNumber
        return pageNumber
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kAmuseMenuCellID, for: indexPath) as! AmuseMenuViewCell
        // 添加数据
        setupCellDataWithCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    private func setupCellDataWithCell(cell : AmuseMenuViewCell,indexPath : IndexPath) {
        // 如果第0页 从0开始  如果第2页 从第8页开始 ...
        // 先取出起始位置 和终点位置
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        // 判断越界问题
        if endIndex > groups!.count - 1 {
            endIndex = groups!.count - 1
        }
        cell.group = Array(groups![startIndex...endIndex])
    }
    
}
extension AmuseMenuView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControllView.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
}
