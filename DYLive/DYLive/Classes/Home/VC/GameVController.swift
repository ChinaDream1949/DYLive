//
//  GameVController.swift
//  DYLive
//
//  Created by MR.Sahw on 2020/9/26.
//

import UIKit

private let kEdgMargin : CGFloat = 10
private let kItemW = (kScreenW - 2 * kEdgMargin) / 3
private let kItemH = kItemW * 4 / 5

private let kGameViewH : CGFloat = 90

private let kGameCellID : String = "kGameCellID"
private let kGameHeaderID : String = "kGameHeaderID"

class GameVController: BaseAnimationVController {
    fileprivate lazy var gameVM : GameViewModel = GameViewModel()
    // 懒加载属性
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgMargin, bottom: 0, right: kEdgMargin)
        // 添加头部
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        // 创建collectionview
        let collectionV = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionV.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionV.backgroundColor = UIColor.white
        collectionV.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        collectionV.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kGameHeaderID)
        collectionV.dataSource = self
        return collectionV
    }()
    // 懒加载属性
    fileprivate lazy var topHeaderView : CollectionHeaderView = {
        let headerView = CollectionHeaderView.collectionHeaderView()
        headerView.frame = CGRect(x: 0, y: -(kHeaderViewH+kGameViewH), width: kScreenW, height: kHeaderViewH)
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.titleLable.text = "常用"
        headerView.moreBtn.isHidden = true
        return headerView
    }()
    fileprivate lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUI()
        loadData()
    }
    

}
extension GameVController {
     override func setupUI() {
        // 1.先给父类中view的引用进行赋值
        contentView = collectionView
        // 2.添加 collectionView
        view.addSubview(collectionView)
        
        collectionView.addSubview(topHeaderView)
        
        collectionView.addSubview(gameView)
        
        collectionView.contentInset = UIEdgeInsets(top: kHeaderViewH+kGameViewH, left: 0, bottom: 0, right: 0)
        // 3.最后super
        super.setupUI()
    }
}
extension GameVController {
    fileprivate func loadData() {
        gameVM.loadAllGameData {
            // 展示全部游戏
            self.collectionView.reloadData()
            // 展示常用游戏
            self.gameView.groups = Array(self.gameVM.games[0..<10])
            // 隐藏
            self.loadDataFinished()
        }
    }
}

extension GameVController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        cell.baseModel = gameVM.games[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1.取出section的headerview
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kGameHeaderID, for: indexPath) as! CollectionHeaderView
        // 2.设置属性
        headerView.titleLable.text = "全部"
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
//        headerView.group = recommendVM.anchorGroups[indexPath.section]
        return headerView
    }
    
}
