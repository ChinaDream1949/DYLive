//
//  DYVideoCell.swift
//  DYLive
//
//  Created by MR.Sahw on 2020/11/22.
//

import UIKit
import MarqueeLabel
import ChainableAnimations
import AVFoundation

typealias OnPlayerReady = () -> Void

class DYVideoCell: UITableViewCell {
    // 动画器
    var animator1 : ChainableAnimator!
    var animator2 : ChainableAnimator!
    
    @IBOutlet var videoV: UIView!
    var playerView:AVPlayerView = AVPlayerView.init()
    var isPlayerReady:Bool = false
    var onPlayerReady:OnPlayerReady?
    var singleTapGesture:UITapGestureRecognizer?
    // 视图UI
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var pauseImageView: UIImageView!
    
    
    @IBOutlet weak var lableAuthor: UILabel!
    @IBOutlet weak var lableDesc: UILabel!
    @IBOutlet weak var lableMiusic: MarqueeLabel!
    
    
    @IBOutlet weak var athorButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLable: UILabel!
    @IBOutlet weak var contentButton: UIButton!
    @IBOutlet weak var contentLable: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var shareLable: UILabel!
    @IBOutlet weak var miusicImageView: UIImageView!
    @IBOutlet weak var retaImagView: UIImageView!
    @IBOutlet weak var retaView: UIView!
    
    // 数组模型
    var groupModel : AnchorModel? {
        didSet {
            lableAuthor.text = groupModel?.nickname
            // 在线人数
            var onlineStr : String = ""
            if groupModel!.online >= 10000 {
                onlineStr = "\(groupModel!.online/10000)万"
            }else{
                onlineStr = "\(groupModel!.online/1)"
            }
            likeLable.text = onlineStr
            let url = URL(string: "\(groupModel?.vertical_src ?? "")")
            coverImageView.kf.setImage(with: url)
            athorButton.kf.setImage(with: url, for: .normal)
            retaImagView.kf.setImage(with: url)

            // 跑马灯
            lableMiusic.text  = "东风破 - 周杰伦"
            lableMiusic.restartLabel()
            
            // 动画唱盘
            animator2 = ChainableAnimator(view: retaView)
            animator2.rotate(angle: 180).animateWithRepeat(t: 3.5, count: 50)
            
            playerView.setPlayerSourceUrl(url: "https://aweme.snssdk.com/aweme/v1/play/?video_id=8168eafd410945228c32f4ffcccb6eb8&line=0&ratio=720p&media_type=4&vr_type=0&test_cdn=None&improve_bitrate=0" )
        }
    }
    
    @IBAction func likeAddBtn(_ sender: UIButton) {
        animator1 = ChainableAnimator(view: sender)
        UIView.transition(with: sender, duration: 0.2, options: .transitionCrossDissolve) {
            sender.setImage(UIImage(named: "iconSignDone"), for: .normal)
        } completion: { (_) in
            self.animator1.rotate(angle:360).thenAfter(t: 0.6).wait(t: 0.3).transform(scale: 0).animate(t: 0.2)
        }
        play()
    }
    override func prepareForReuse() {
        isPlayerReady = false
        playerView.cancelLoading()
        pauseImageView.isHidden = true
        // 重置关注按钮所以动画
        if animator1 != nil {
            animator1.stop()
            addButton.transform = .identity
            addButton.layer.removeAllAnimations()
            addButton.setImage(UIImage(named: "icon_personal_add_little"), for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        playerView.delegate = self
        videoV.addSubview(playerView)
        
        singleTapGesture = UITapGestureRecognizer.init(target: self, action: #selector(handleGesture(sender:)))
        videoV.addGestureRecognizer(singleTapGesture!)
        
    }
    func play() {
        playerView.play()
    }
    
    func pause() {
        playerView.pause()
    }
    
    func replay() {
        playerView.replay()
    }
    @objc func handleGesture(sender: UITapGestureRecognizer) {
        showPauseViewAnim(rate: playerView.rate())
        playerView.updatePlayerState()
    }
    func showPauseViewAnim(rate:CGFloat) {
        if rate == 0 {
            UIView.animate(withDuration: 0.25, animations: {
                self.pauseImageView.alpha = 0.0
            }) { finished in
                self.pauseImageView.isHidden = true
            }
        } else {
            pauseImageView.isHidden = false
            pauseImageView.transform = CGAffineTransform.init(scaleX: 1.8, y: 1.8)
            pauseImageView.alpha = 1.0
            UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseIn, animations: {
                self.pauseImageView.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            }) { finished in
            }
        }
    }
}

extension DYVideoCell: AVPlayerUpdateDelegate {
    
    func onProgressUpdate(current: CGFloat, total: CGFloat) {
        
    }
    
    func onPlayItemStatusUpdate(status: AVPlayerItem.Status) {
        switch status {
        case .unknown:
//            startLoadingPlayItemAnim()
            break
        case .readyToPlay:
//            startLoadingPlayItemAnim(false)
            
            isPlayerReady = true
//            musicAlum.startAnimation(rate: CGFloat(aweme?.rate ?? 0))
            onPlayerReady?()
            break
        case .failed:
//            startLoadingPlayItemAnim(false)
            break
        @unknown default:
            break
        }
    }
    
}
