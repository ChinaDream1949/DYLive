//
//  AmuseMenuViewCell.swift
//  DYLive
//
//  Created by MR.Sahw on 2020/9/26.
//

import UIKit

private let kGameCellID = "kGameCellID"

class AmuseMenuViewCell: UICollectionViewCell {
    // 数组模型
    var group : [AnchorGroup]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: (collectionView.bounds.width/4), height: collectionView.bounds.height/2)
        
    }

}

extension AmuseMenuViewCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return group?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        cell.clipsToBounds = true
        cell.baseModel = group![indexPath.item]
        return cell
    }
    
    
}
