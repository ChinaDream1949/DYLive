//
//  CollectionHeaderView.swift
//  DYLive
//
//  Created by MR.Sahw on 2020/9/24.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var moreBtn: UIButton!
    
    var group : AnchorGroup? {
        didSet {
            titleLable.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
}

// 从xib中快速创建类方法
extension CollectionHeaderView {
    class func collectionHeaderView() -> CollectionHeaderView {
        return Bundle.main.loadNibNamed("CollectionHeaderView", owner: nil, options: nil)?.first as! CollectionHeaderView
    }
}
