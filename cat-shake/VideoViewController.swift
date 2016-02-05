//
//  VideoViewController.swift
//  cat-shake
//
//  Created by Mack on 2/3/16.
//  Copyright © 2016 Mack. All rights reserved.
//

import UIKit
import SnapKit
import XCDYouTubeKit

class VideoViewController: UIViewController {
    var player: XCDYouTubeVideoPlayerViewController?
    let playerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blueColor()
        setupPlayerView()
    }
    
    func setupPlayerView() {
        view.addSubview(playerView)
        playerView.snp_remakeConstraints { (make) -> Void in
            make.width.equalTo(view)
            make.height.equalTo(view)
            make.center.equalTo(view)
        }
    }
    
    func playVideo(playlist: VideoList) {
        let randomVid = playlist.randomVideo(nil)
        guard let selectedVideo = randomVid.id else {
            return
        }
        player = XCDYouTubeVideoPlayerViewController(videoIdentifier: selectedVideo)
        player?.presentInView(playerView)
        player?.moviePlayer.play()
        player?.hidesBottomBarWhenPushed = true
    }
    
}
