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
    var previousVideo: Video?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    func prepareVideo(var playlist: VideoList) {
        if let previoius = previousVideo {
            let randomVid = playlist.randomVideo(previoius)
            player?.removeFromParentViewController()
            play(randomVid)
        } else {
            let randomVid = playlist.randomVideo(nil)
            play(randomVid)
        }
    }
    
    func play(video: Video) {
        previousVideo = video
        guard let id = video.id else {
            print("*** id is null in play video *** ")
            return
        }
        print("about to play vid with id \(id)")
        player = XCDYouTubeVideoPlayerViewController(videoIdentifier: id)
//        player?.preferredVideoQualities = ["XCDYouTubeVideoQualityMedium360"]
        player?.presentInView(playerView)
        player?.moviePlayer.controlStyle = MPMovieControlStyle.None
        player?.moviePlayer.prepareToPlay()
        player?.moviePlayer.fullscreen = true
        player?.moviePlayer.play()
    }
}
