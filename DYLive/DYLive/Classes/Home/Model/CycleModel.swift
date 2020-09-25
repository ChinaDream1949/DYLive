//
//  CycleModel.swift
//  DYLive
//
//  Created by MR.Sahw on 2020/9/25.
//

import UIKit

class CycleModel: NSObject {
    @objc var title : String = ""
    @objc var pic_url : String = ""
    @objc var room : [String : NSObject]? {
        didSet{
            guard let room = room else { return }
            anchor = AnchorModel(dict: room)
        }
    }
    @objc var anchor : AnchorModel?
    
    // 自定义构造函数
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {} // 防止报错
}
