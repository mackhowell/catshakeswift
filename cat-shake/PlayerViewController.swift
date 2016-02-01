//
//  ViewController.swift
//  cat-shake
//
//  Created by Mack on 1/31/16.
//  Copyright © 2016 Mack. All rights reserved.
//

import UIKit
import YouTubePlayer
import SnapKit

class PlayerViewController: UIViewController {
    
    let videoView = YouTubePlayerView()
    var videoList: VideoList?
    var currentVideo: Video?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        
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

extension PlayerViewController: YouTubePlayerDelegate {
    func playerReady(videoPlayer: YouTubePlayerView) {
        videoView.play()
    }
    
    func playerStateChanged(videoPlayer: YouTubePlayerView, playerState: YouTubePlayerState) {
    }
    
    func playerQualityChanged(videoPlayer: YouTubePlayerView, playbackQuality: YouTubePlaybackQuality) {
    }
}

