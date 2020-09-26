//
//  GameViewModel.swift
//  DYLive
//
//  Created by MR.Sahw on 2020/9/26.
//

import UIKit

class GameViewModel {
    lazy var games : [GameModel] = [GameModel]()
}

extension GameViewModel {
    func loadAllGameData (finishedCallBack : @escaping () -> ()) {
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName":""]) { (result) in
            // 1.先将 result 转成字典
            guard let resultDict = result as? [String : NSObject] else { return }
            // 2.根据 resultDict 获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            // 3.遍历数组,获取字典，并且转成模型对象
            for dict in dataArray {
                let group = GameModel(dict: dict)
                self.games.append(group)
            }
            finishedCallBack()
        }
    }
}
