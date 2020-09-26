//
//  ReCommendVC.swift
//  DYLive
//
//  Created by MR.Sahw on 2020/9/24.
//

import UIKit

private let kItenmMargin :CGFloat = 10
private let kItemW = (kScreenW - 3*kItenmMargin) / 2


private let kCycleViewH = kScreenW * 3 / 8
private let krecomendGameH : CGFloat = 90


class ReCommendVC: BaseAnchorViewController {
    // MARK - 懒加载属性
    private lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    
    // MARK - 懒加载属性
    private lazy var cycleView : CommendCyleView = {
        let cycleView = CommendCyleView.recommedCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH+krecomendGameH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    // MARK - 懒加载属性
    private lazy var recommendGameV : RecommendGameView = {
        let recommendGameview = RecommendGameView.recommendGameView()
        recommendGameview.frame = CGRect(x: 0, y: -krecomendGameH, width: kScreenW, height: krecomendGameH)
        return recommendGameview
    }()

}

extension ReCommendVC {
    override func setupUI() {
        // 先调用super.setupUI()
        super.setupUI()
        // 将 collectionView 添加到view
        view.addSubview(collectionView)
        // 将 cycleView 添加到collectionView
        collectionView.addSubview(cycleView)
        // 将 recommedGameView 添加到collectionView
        collectionView.addSubview(recommendGameV)
        // 设置collectionView 顶部内边距 (轮播图出现)
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + krecomendGameH, left: 0, bottom: 0, right: 0)
    }
}
// MARK 请求数据
extension ReCommendVC {
    override func loadData() {
        // 给父类baseVM进行赋值
        baseVM = recommendVM
        // 请求推荐数据
        recommendVM.requesData {
            self.collectionView.reloadData()
            var groups = self.recommendVM.anchorGroups
            groups.removeFirst()
            groups.removeFirst()//删除前两组数据
            // 添加更多
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            self.recommendGameV.groups = groups
            
            // 隐藏
            self.loadDataFinished()
        }
        // 请求轮播数据
        recommendVM.requestCycleDate {
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
    }
}
// 如果对父类控件，布局不满意 可以继承重写
extension ReCommendVC : UICollectionViewDelegateFlowLayout{
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            // 1.取出prettycell
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
            prettyCell.anchor = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.row]
            return prettyCell
        }else{
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        return CGSize(width: kItemW, height: kNormalItemH)
    }
}
    

