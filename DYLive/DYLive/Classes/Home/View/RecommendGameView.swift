//
//  RecommendGameView.swift
//  DYLive
//
//  Created by MR.Sahw on 2020/9/25.
//

import UIKit

private let kGmaeCellID = "kGmaeCellID"
private let kEdgMragin : CGFloat = 10

class RecommendGameView: UIView {
    // 定义数据属性
    var groups : [AnchorGroup]? {
        didSet{
            groups?.removeFirst()
            groups?.removeFirst()//删除前两组数据
            // 添加更多
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups?.append(moreGroup)
            
            collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = []
        
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGmaeCellID)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: kEdgMragin, bottom: 0, right: kEdgMragin)
    }
}

extension RecommendGameView {
    class func recommendGameView() -> RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}

extension RecommendGameView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGmaeCellID, for: indexPath) as! CollectionGameCell
        cell.group = groups![indexPath.item]
        return cell
    }
    
    
}
