//
//  PlayerLogger.swift
//  cat-shake
//
//  Created by Mack Howell on 2/22/16.
//  Copyright © 2016 Mack. All rights reserved.
//

import UIKit
import XCDYouTubeKit

class PlayerLogger {
    
    static let sharedManager = PlayerLogger()
    var enabled: Bool = false

    func setEnabled(enabled: Bool) {
        if self.enabled == enabled {
            return
        }
        
        self.enabled = enabled
        let defaultCenter = NSNotificationCenter.defaultCenter()
        if enabled {
            defaultCenter.addObserver(self, selector: "videoPlayerViewControllerDidReceiveVideo:", name: XCDYouTubeVideoPlayerViewControllerDidReceiveVideoNotification, object: nil)
            defaultCenter.addObserver(self, selector: "moviePlayerPlaybackDidFinish:", name: MPMoviePlayerPlaybackDidFinishNotification, object: nil)
            defaultCenter.addObserver(self, selector: "moviePlayerPlaybackStateDidChange:", name: MPMoviePlayerPlaybackStateDidChangeNotification, object: nil)
            defaultCenter.addObserver(self, selector: "moviePlayerLoadStateDidChange:", name: MPMoviePlayerLoadStateDidChangeNotification, object: nil)
        } else {
            defaultCenter.removeObserver(self, name: XCDYouTubeVideoPlayerViewControllerDidReceiveVideoNotification, object: nil)
            defaultCenter.removeObserver(self, name: MPMoviePlayerPlaybackDidFinishNotification, object: nil)
            defaultCenter.removeObserver(self, name: MPMoviePlayerPlaybackStateDidChangeNotification, object: nil)
            defaultCenter.removeObserver(self, name: MPMoviePlayerLoadStateDidChangeNotification, object: nil)
        }
    }
    
    func videoPlayerViewControllerDidReceiveVideo(notification: NSNotification) {
        print("player did recieve video: \(notification.userInfo?[XCDYouTubeVideoUserInfoKey])")
    }
    
    func moviePlayerPlaybackDidFinish(notification: NSNotification) {
        let finishReason = notification.userInfo?[XCDMoviePlayerPlaybackDidFinishErrorUserInfoKey] as? MPMovieFinishReason
        let error = notification.userInfo?[XCDMoviePlayerPlaybackDidFinishErrorUserInfoKey] as? NSError
        var reasonString = ""
        
        guard let reason = finishReason else {
            print("coudln't unwrap finish reason player logger")
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
    
    func moviePlayerPlaybackStateDidChange(notification: NSNotification) {
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
    
    func moviePlayerLoadStateDidChange(notification: NSNotification) {
        let mpc = notification.object as? MPMoviePlayerController
        guard let playerController = mpc else {
            return
        }
        
        var loadState = ""
        switch playerController.loadState {
        case MPMovieLoadState.Playable:
            loadState = "playable"
        case MPMovieLoadState.PlaythroughOK:
            loadState = "playthrough OK"
        case MPMovieLoadState.Stalled:
            loadState = "stalled"
        case MPMovieLoadState.Unknown:
            loadState = "unknown"
        default:
            loadState = "default"
        }
        
        print("player loading state: \(loadState)")
    }
}
