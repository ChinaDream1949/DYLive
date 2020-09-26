//
//  BaseViewModel.swift
//  DYLive
//
//  Created by MR.Sahw on 2020/9/26.
//

import UIKit

class BaseViewModel {
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]() // 外界使用 删除 private
}

extension BaseViewModel {
    func loadAnchorData(isGroupData : Bool,URLString : String , parameters : [String :Any]? = nil,finishedCallBack : @escaping () ->()){
        NetworkTools.requestData(.get, URLString: URLString, parameters: parameters) { (result) in
            // 1.先将 result 转成字典
            guard let resultDict = result as? [String : NSObject] else { return }
            // 2.根据 resultDict 获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            // 2.5判断是不是分组数据
            if isGroupData {
                // 3.遍历数组,获取字典，并且转成模型对象
                for dict in dataArray {
                    self.anchorGroups.append(AnchorGroup(dict: dict))
                }
            }else{
                // 2.1 创建组
                let group = AnchorGroup()
                // 2.2遍历dataArray的所有字典
                for dict in dataArray {
                    group.anchors.append(AnchorModel(dict: dict))
                }
                // 2.3 添加到 anchorGroups
                self.anchorGroups.append(group)
            }
            
            finishedCallBack()
        }

    }
}
