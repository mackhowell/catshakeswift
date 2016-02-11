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
//        view.backgroundColor = UIColor.blueColor()
        setupPlayerView()
        let defaultCenter = NSNotificationCenter.defaultCenter()
        defaultCenter.addObserver(self, selector: "playerStateDidChange", name: MPMoviePlayerLoadStateDidChangeNotification, object: nil)
    }
    
    func setupPlayerView() {
        view.addSubview(playerView)
        playerView.snp_remakeConstraints { (make) -> Void in
            make.width.equalTo(view)
            make.height.equalTo(view)
            make.center.equalTo(view)
        }
    }
    
    func playerStateDidChange() {
        print("hi")
    }
    
    func playVideo(playlist: VideoList) {
        let randomVid = playlist.randomVideo(nil)
        guard let selectedVideo = randomVid.id else {
            return
        }
        print("playing id: \(selectedVideo)")
        player = XCDYouTubeVideoPlayerViewController(videoIdentifier: selectedVideo)
//        player?.preferredVideoQualities = ["XCDYouTubeVideoQualityMedium360"]
        player?.presentInView(playerView)
        player?.moviePlayer.controlStyle = MPMovieControlStyle.None
        player?.moviePlayer.prepareToPlay()
        player?.moviePlayer.fullscreen = true
        player?.moviePlayer.play()
        if player?.moviePlayer.readyForDisplay == true {
            print("video is ready")
        }
    }
    
    func setControlState() {
//        player?.moviePlayer.controlStyle = MPMovieControlStyle.Fullscreen
    }
    
}
