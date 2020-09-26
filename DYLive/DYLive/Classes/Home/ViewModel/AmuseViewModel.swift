//
//  AmuseViewModel.swift
//  DYLive
//
//  Created by MR.Sahw on 2020/9/26.
//

import UIKit

class AmuseViewModel : BaseViewModel{
//    lazy var group : [AnchorGroup] = [AnchorGroup]()
}

extension AmuseViewModel {
    func loadAmuseData(finishedCallBck : @escaping () ->()) {
//        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", parameters: nil) { (result) in
//            // 1.先将 result 转成字典
//            guard let resultDict = result as? [String : NSObject] else { return }
//            // 2.根据 resultDict 获取数组
//            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
//            // 3.遍历数组,获取字典，并且转成模型对象
//            for dict in dataArray {
//                self.group.append(AnchorGroup(dict: dict))
//            }
//        finishedCallBck()
//        }
        loadAnchorData(isGroupData: true,URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", parameters: nil, finishedCallBack: finishedCallBck)
    }
}
