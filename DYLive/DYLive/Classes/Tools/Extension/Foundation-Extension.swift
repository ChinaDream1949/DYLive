//
//  Foundation-Extension.swift
//  DYLive
//
//  Created by MR.Sahw on 2020/9/24.
//

import Foundation

extension NSDate {
    class func getCurrentTime() -> String {
        let nowDate = NSDate()
        let interval = nowDate.timeIntervalSince1970
        return "\(interval)"
    }
}
