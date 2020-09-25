//
//  CollectionGameCell.swift
//  DYLive
//
//  Created by MR.Sahw on 2020/9/25.
//

import UIKit

class CollectionGameCell: UICollectionViewCell {

    var group : AnchorGroup? {
        didSet{
            titleLab.text = group?.tag_name
            let url = URL(string: "\(group?.icon_url ?? "")")
//            iconImageView.kf.setImage(with: url)
            iconImageView.kf.setImage(with: url, placeholder: UIImage(named: "home_more_btn"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
