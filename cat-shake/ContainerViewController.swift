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

//protocol PlayerDelegate: class {
//    func playVideo()
//}

class ContainerViewController: UIViewController {
    
    let videoViewController = VideoViewController()
    let interstitialViewController = InterstitialViewController()
    var videoList: VideoList?
    var currentVideo: Video?
    var isPlayingVideo: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        setupSubControllers()
        
        // Gets first 50 videos
        NetworkManager.getYoutubePlaylist({ (list, error) -> () in
            if (error != nil) {
                print("error in getting playlist closure")
            } else {
                self.videoList = list
                self.videoViewController.playVideo()
            }
        })
    }

    func setupSubControllers() {
        view.addSubview(interstitialViewController.view)
        addChildViewController(interstitialViewController)
        view.addSubview(videoViewController.view)
        addChildViewController(videoViewController)
    }
    
    func swapScreens() {
        // add fade
        if isPlayingVideo {
            view.bringSubviewToFront(interstitialViewController.view)
            view.sendSubviewToBack(videoViewController.view)
        } else {
            view.bringSubviewToFront(videoViewController.view)
            view.sendSubviewToBack(interstitialViewController.view)
        }
        
        isPlayingVideo = !isPlayingVideo
    }
}

