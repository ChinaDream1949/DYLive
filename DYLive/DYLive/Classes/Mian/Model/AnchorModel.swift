//
//  AnchorModel.swift
//  DYLive
//
//  Created by MR.Sahw on 2020/9/24.
//

import UIKit

class AnchorModel: BaseGameModel {
    // 房间号
    @objc var room_id : Int = 0
    // 房间图片
    @objc var vertical_src : String = ""
    // 判断是手机直播（1）还是 电脑直播（0）
    @objc var isVertical : Int = 0
    // 房间名称
    @objc var room_name : String = ""
    // 主播昵称
    @objc var nickname : String = ""
    // 在线人数
    @objc var online : Int = 0
    // 所在城市
    @objc var anchor_city : String = ""
    
}
