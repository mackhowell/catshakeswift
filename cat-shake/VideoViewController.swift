//
//  VideoViewController.swift
//  cat-shake
//
//  Created by Mack on 2/3/16.
//  Copyright © 2016 Mack. All rights reserved.
//

import UIKit
import YouTubePlayer
import SnapKit

class VideoViewController: BaseViewController {
    let videoView = YouTubePlayerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blueColor()
        
        // Gets first 50 videos
        NetworkManager.getYoutubePlaylist({(list, error) -> () in
            self.videoList = list
            self.playVideo()
        })
        
        setupPlayerView()
    }
    
    func setupPlayerView() {
        view.addSubview(videoView)
        videoView.snp_remakeConstraints { (make) -> Void in
            make.width.equalTo(view)
            make.height.equalTo(view)
            make.center.equalTo(view)
        }
    }
    
    func playVideo() {
        let randomVid = videoList?.randomVideo(nil)
        guard let selectedVideo = randomVid?.id else {
            return
        }
        videoView.loadVideoID(selectedVideo)
    }
    
}

extension VideoViewController: YouTubePlayerDelegate {
    func playerReady(videoPlayer: YouTubePlayerView) {
        videoView.play()
    }
    
    func playerStateChanged(videoPlayer: YouTubePlayerView, playerState: YouTubePlayerState) {
    }
    
    func playerQualityChanged(videoPlayer: YouTubePlayerView, playbackQuality: YouTubePlaybackQuality) {
    }
}
