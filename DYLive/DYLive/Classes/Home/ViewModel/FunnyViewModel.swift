//
//  FunnyViewModel.swift
//  DYLive
//
//  Created by MR.Sahw on 2020/9/26.
//

import UIKit

class FunnyViewModel : BaseViewModel{
    func loadFunnyData(finishedCallBack : @escaping () -> ()) {
        loadAnchorData(isGroupData: false,URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/2", parameters: ["limit" : 30, "offset" : 0], finishedCallBack: finishedCallBack)
    }
}
