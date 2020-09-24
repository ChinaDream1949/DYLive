//
//  CollectionBaseCell.swift
//  DYLive
//
//  Created by MR.Sahw on 2020/9/25.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nickNameLab: UILabel!
    var anchor : AnchorModel? {
        didSet {
            // 校验模型是否有值
            guard let anchor = anchor else { return }
            // 在线人数
            var onlineStr : String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(anchor.online/10000)万在线"
            }else{
                onlineStr = "\(anchor.online/1)在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            // 昵称
            nickNameLab.text = anchor.nickname
            // 封面
            let url = URL(string: "\(anchor.vertical_src)")
            iconImageView.kf.setImage(with: url)
        }
    }
}
