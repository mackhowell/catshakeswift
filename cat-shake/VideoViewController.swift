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
    weak var delegate: TriggerVideoFromChildViewController?
//    let logger = PlayerLogger()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlayerView()
        
//        let defaultCenter = NSNotificationCenter.defaultCenter()
//        defaultCenter.addObserver(self, selector: "moviePlayerPlaybackStateDidChange:", name: MPMoviePlayerPlaybackStateDidChangeNotification, object: player?.moviePlayer)
//        defaultCenter.addObserver(self, selector: "moviePlayerPlaybackDidFinish:", name: MPMoviePlayerPlaybackDidFinishNotification, object: player?.moviePlayer)
        
        // TODO: Use PlayerLogger to setup notifications on player.
//        let logger = PlayerLogger.sharedManager.setEnabled = true
    }
    
    func setupPlayerView() {
        view.addSubview(playerView)
        playerView.snp_remakeConstraints { (make) -> Void in
            make.width.equalTo(view)
            make.height.equalTo(view)
            make.center.equalTo(view)
        }
    }
    
    func moviePlayerPlaybackStateDidChange(notification: NSNotification) {
//        print("player state = \(player?.moviePlayer.playbackState)")
//        if player?.moviePlayer.playbackState == MPMoviePlaybackState. {
//            delegate?.prepareVideo()
//        }
        let mpc = notification.object as? MPMoviePlayerController
        guard let playerController = mpc else {
            return
        }
        
        var playbackState = ""
        switch playerController.playbackState {
        case .Stopped:
            playbackState = "stopped"
        case .Playing:
            playbackState = "playing"
        case .Paused:
            playbackState = "paused"
        case .Interrupted:
            playbackState = "interrupted"
        default:
            playbackState = "default"
        }
        
        print("player playing state: \(playbackState)")
    }
    
    func moviePlayerPlaybackDidFinish(notification: NSNotification) {
        let finishReason = notification.userInfo?[XCDMoviePlayerPlaybackDidFinishErrorUserInfoKey] as? MPMovieFinishReason
        let error = notification.userInfo?[XCDMoviePlayerPlaybackDidFinishErrorUserInfoKey] as? NSError
        var reasonString = ""
        
        guard let reason = finishReason else {
            print("coudln't unwrap finish reason")
            return
        }
        
        switch (reason) {
        case .PlaybackEnded:
            reasonString = "Playback Ended"
            break
        case .PlaybackError:
            reasonString = "Playback Error: \(error)"
            break
        case .UserExited:
            reasonString = "User Exited"
            break
        }
        
        print("player finished with reason: \(reasonString)")
    }
    
    func prepareVideo(var playlist: VideoList) {
        if let previoius = previousVideo {
            let randomVid = playlist.randomVideo(previoius)
            player?.view.removeFromSuperview()
            player = nil
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
