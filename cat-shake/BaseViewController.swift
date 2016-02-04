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

class BaseViewController: UIViewController {
    
    let videoViewController = VideoViewController()
    let interstitialViewController = InterstitialViewController()
    var videoList: VideoList?
    var currentVideo: Video?
    var isPlayingVideo: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        
        // Gets first 50 videos
        NetworkManager.getYoutubePlaylist({(list, error) -> () in
            self.videoList = list
        })
        
        setupSubControllers()
        swapScreens()
    }

    func setupSubControllers() {
        view.addSubview(videoViewController.view)
        addChildViewController(videoViewController)
        view.addSubview(interstitialViewController.view)
        addChildViewController(interstitialViewController)
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
        !isPlayingVideo
    }
}

