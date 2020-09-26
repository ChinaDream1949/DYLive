//
//  BaseAnchorViewController.swift
//  DYLive
//
//  Created by MR.Sahw on 2020/9/26.
//

import UIKit

private let kItenmMargin :CGFloat = 10
private let kItemW = (kScreenW - 3*kItenmMargin) / 2
let kNormalItemH = kItemW * 3 / 4
let kPrettyItemH = kItemW * 4 / 3
let kHeaderViewH : CGFloat = 50

private let kNormalCellID : String = "kNormalCellID"
let kPrettyCellID : String = "kPrettyCellID"
private let kHeaderViewID : String = "kHeaderViewID"

class BaseAnchorViewController: BaseAnimationVController {

    // 定义属性
    var baseVM : BaseViewModel!
    // 懒加载属性
    lazy var collectionView : UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItenmMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItenmMargin, bottom: 0, right: kItenmMargin)
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        collectionView.register(UINib(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        return collectionView
    }()
    // 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
}
// 设置UI界面
extension BaseAnchorViewController {
   override  func setupUI() {
    // 1.先给父类中view的引用进行赋值
    contentView = collectionView
    // 2.添加 collectionView
    view.addSubview(collectionView)
    // 3.最后super
    super.setupUI()
    }
}
// 请求数据
extension BaseAnchorViewController {
     @objc func loadData() {
        
    }
}
extension BaseAnchorViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if baseVM == nil {
            return 20
        }
        return baseVM.anchorGroups[section].anchors.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if baseVM == nil {
            return 1
        }
        return baseVM.anchorGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionViewNormalCell
        if baseVM == nil {
            return cell
        }
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1.取出section的headerview
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        if baseVM == nil {
            return headerView
        }
        // 2.取出模型
        headerView.group = baseVM.anchorGroups[indexPath.section]
        return headerView
    }
}
extension BaseAnchorViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.section)-\(indexPath.item)")
        // 1.取出主播信息
        let anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        // 2.判断是show场房间 还是 普通房间
        anchor.isVertical == 0 ? presentNoramlRoomVC() : presentShowRoomVC()
        
    }
    private func presentShowRoomVC() {
        // 1.创建showvc
        let showRoomVC = RoomShowViewController()
        if #available(iOS 13.0, *) {
            showRoomVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        } else {
            // Fallback on earlier versions
        }
        // 2.以modal方式弹出
        present(showRoomVC, animated: true, completion: nil)
    }
    private func presentNoramlRoomVC() {
        // 1.创建showvc
        let noramalRoomVC = RoomNoramlViewController()
        // 2.以modal方式弹出
        navigationController?.pushViewController(noramalRoomVC, animated: true)
    }
}
