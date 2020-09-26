//
//  RecommendViewModel.swift
//  DYLive
//
//  Created by MR.Sahw on 2020/9/24.
//

import UIKit

class RecommendViewModel : BaseViewModel{
    // MRAK 懒加载属性
    lazy var cycleModels : [CycleModel] = [CycleModel]() // 外界使用 删除 private
    private lazy var bigDateGroup : AnchorGroup = AnchorGroup()
    private lazy var prettyGroup : AnchorGroup = AnchorGroup()
}

extension RecommendViewModel {
    func requesData(finishedCallBack : @escaping () -> ()) {//如果函数里执行该闭包，要添加@escaping。
        // 0.创建group (确保数据全部请求完成后，添加数据顺序一致)
        let groupDis = DispatchGroup.init()
        
        // 1.请求推荐数据
        groupDis.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time":NSDate.getCurrentTime]) { (result) in
            // 1.先将 result 转成字典
            guard let resultDict = result as? [String : NSObject] else { return }
            // 2.根据 resultDict 获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            // 3.遍历数组,获取字典，并且转成模型对象
            // 3.1 设置组
            self.bigDateGroup.tag_name = "热门"
            self.bigDateGroup.icon_name = "home_header_hot"
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.bigDateGroup.anchors.append(anchor)
            }
            groupDis.leave()
            print("请求完成0组数据")
        }
        // 2.请求颜值数据
        groupDis.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: ["limit":"4","offset":"0","time":NSDate.getCurrentTime]) { (result) in
            // 1.先将 result 转成字典
            guard let resultDict = result as? [String : NSObject] else { return }
            // 2.根据 resultDict 获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            // 3.遍历数组,获取字典，并且转成模型对象
            // 3.1 设置组
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            groupDis.leave()
            print("请求完成1组数据")
        }
        // 3.请求后面部分的游戏数据
        groupDis.enter()

        loadAnchorData(isGroupData: true,URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: ["limit":"4","offset":"0","time":NSDate.getCurrentTime]) {
            groupDis.leave()
        }
        // 6.所有数据请求完成 ， 之后排序
        groupDis.notify(queue: .main) {
            print("所有的任务执行完了")
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDateGroup, at: 0)
            finishedCallBack()
        }
    }
    
    
    /// 请求轮播数据
    func requestCycleDate(finishedCallBack : @escaping () -> ()){
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/slide/6", parameters: ["version":"2.300"]) { (result) in
            // 1.先将 result 转成字典
            guard let resultDict = result as? [String : NSObject] else { return }
            // 2.根据 resultDict 获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            // 3.遍历数组,获取字典，并且转成模型对象
            for dict in dataArray {
                let group = CycleModel(dict: dict)
                self.cycleModels.append(group)
            }
            finishedCallBack()
        }
    }
}
