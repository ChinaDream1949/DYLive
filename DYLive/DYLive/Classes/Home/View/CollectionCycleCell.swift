//
//  CollectionCycleCell.swift
//  DYLive
//
//  Created by MR.Sahw on 2020/9/25.
//

import UIKit

class CollectionCycleCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLab: UILabel!
    // 定义模型属性
    var cycleModel : CycleModel? {
        didSet {
            titleLab.text = cycleModel?.title
            let url = URL(string: "\(cycleModel?.pic_url ?? "")")
            iconImageView.kf.setImage(with: url)
        }
    }

}
