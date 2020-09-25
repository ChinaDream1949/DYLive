//
//  AnchorGroup.swift
//  DYLive
//
//  Created by MR.Sahw on 2020/9/24.
//

//在swift3中，编译器自动推断@objc，换句话说，它自动添加@objc
//在swift4中，编译器不再自动推断，必须显式添加@objc

import UIKit

class AnchorGroup: NSObject {
    // 该组对应的房间信息
    @objc var room_list : [[String : NSObject]]? {
        didSet {
            guard let room_list = room_list else { return }
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    // 显示组的标题
    @objc var tag_name : String = ""
    // 该组显示的图标
    @objc var icon_name : String = "home_header_normal"
    // 游戏对应的图标
    @objc var icon_url : String = ""
    // 定义主播模型对象数组
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    
    override init() {
        
    }
    
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {} // 防止报错
//    override func setValue(_ value: Any?, forKey key: String) {
//        if key == "room_list"
//        {
//            if let dataArray = value as? [[String : NSObject]]
//            {
//                for dict in dataArray
//                {
//                    anchors.append(AnchorModel(dict: dict))
//                }
//            }
//        }
//    }
}
