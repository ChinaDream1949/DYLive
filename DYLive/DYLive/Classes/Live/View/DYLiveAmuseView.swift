//
//  DYLiveAmuseView.swift
//  DYLive
//
//  Created by MR.Sahw on 2020/11/22.
//

import UIKit

private let kLiveAmuseCellID = "DYVideoCell"

class DYLiveAmuseView: UIView {

//    var currentPage = 0
    @objc dynamic var currentPage:Int = 0
    var isCurPlayerPause:Bool = false
    // 定义属性
    var groups : [AnchorGroup]? {
        didSet{
            dyLiveTableView.reloadData()
        }
    }
    
    @IBOutlet weak var dyLiveTableView: UITableView!
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        dyLiveTableView.delegate = self
        dyLiveTableView.dataSource = self
        dyLiveTableView.register(UINib(nibName: kLiveAmuseCellID, bundle: nil), forCellReuseIdentifier: kLiveAmuseCellID)
    }
}

extension DYLiveAmuseView {
    class func liveAmuseView() -> DYLiveAmuseView{
        return Bundle.main.loadNibNamed("DYLiveAmuseView", owner: nil, options: nil)?.first as! DYLiveAmuseView
    }
}

extension DYLiveAmuseView:UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        currentPage = dyLiveTableView.indexPathsForVisibleRows!.last!.row
        print(currentPage)
        self.addObserver(self, forKeyPath: "currentPage", options: [.initial], context: nil)
    }
}
extension DYLiveAmuseView {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if(keyPath == "currentPage") {
            isCurPlayerPause = false
            weak var cell = dyLiveTableView.cellForRow(at: IndexPath.init(row: currentPage, section: 0)) as? DYVideoCell
            if cell?.isPlayerReady ?? false {
                cell?.replay()
            } else {
                AVPlayerManager.shared().pauseAll()
                cell?.onPlayerReady = {[weak self] in
                    if let indexPath = self?.dyLiveTableView.indexPath(for: cell!) {
                        if !(self?.isCurPlayerPause ?? true) && indexPath.row == self?.currentPage {
                            cell?.play()
                        }
                    }
                }
            }
        }else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
}
extension DYLiveAmuseView : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kScreenH
    }
}

extension DYLiveAmuseView : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if groups?[section].anchors.count == nil { return 0}
        return groups![section].anchors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kLiveAmuseCellID, for: indexPath) as! DYVideoCell
        cell.groupModel = groups?[indexPath.section].anchors[indexPath.row]
        return cell
    }
    
    
}
