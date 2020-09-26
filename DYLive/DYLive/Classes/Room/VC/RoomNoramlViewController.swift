//
//  RoomNoramlViewController.swift
//  DYLive
//
//  Created by MR.Sahw on 2020/9/26.
//

import UIKit
import AVFoundation

class RoomNoramlViewController: UIViewController , UIGestureRecognizerDelegate{

    // MARK - 懒加载属性
    private lazy var videoView : UIView = {
        let cycleView = UIView()
        cycleView.frame = CGRect(x: 0, y:0, width: kScreenW, height: 300)
        return cycleView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}

extension RoomNoramlViewController {
    func setupUI() {
        videoView.backgroundColor = UIColor.red
        view.addSubview(videoView)
        let url = URL(string: "http://ivi.bupt.edu.cn/hls/cctv1hd.m3u8")!
        let palyer = AVPlayer(url: url)
        let playLayer = AVPlayerLayer(player: palyer)
        playLayer.frame = videoView.bounds
        videoView.layer.addSublayer(playLayer)
        
        
        palyer.play()
    }
}
