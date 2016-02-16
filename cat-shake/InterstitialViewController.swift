
//
//  InterstitialViewController.swift
//  cat-shake
//
//  Created by Mack on 1/31/16.
//  Copyright © 2016 Mack. All rights reserved.
//
import UIKit

class InterstitialViewController: UIViewController {
//    var catGifArray = [UIImage]()
    let gifView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // view.backgroundColor = UIColor.redColor()
        setUpGifView()
//        self.checkAnimationImages(self.catGifName)
        //animateImage()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        playRandomGif()
    }
    
    func setUpGifView() {
        view.addSubview(gifView)
        gifView.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
        }
    }
    
    var catGifNameArray:[String] = [
        "3d",
        "piano1",
        "aquarium",
        "bag",
        "bitey",
        "black",
        "blackcat",
        "blacksleep",
        "blink",
        "blinky",
        "click",
        "cloud",
        "computer",
        "guitar",
        "kittens",
        "licking",
        "lickscreen",
        "mouse",
        "pawface",
        "persia",
        "piano",
        "piano1",
        "psych",
        "rainbow",
        "sleepy",
        "snow",
        "sparkle",
        "sparkly",
        "sparkly2",
        "standing",
        "trio",
        "tv",
        "wagging",
        "walking",
        "window",
        "cosmic",
        "desk",
        "waving",
    ]
    
//    func checkAnimationImages(fileNames: [String]) -> [AnyObject] {
//        for name in fileNames {
//            var i = 0
//            //var catGifArray = [UIImage]()
//            var image = UIImage(named: "\(name)-\(i)")
//            while (image != nil){
//                catGifArray.append(image!)
//                ++i
//                image = UIImage(named: "\(name)-\(i)")
//            }
//        }
//        self.gifView.animationImages = catGifArray;
//        self.gifView.animationDuration = 1.0
//        self.gifView.startAnimating()
//        
//        return catGifArray.map {
//            return $0.CGImage as! AnyObject
//        }
//    }
    
    func gifAnimationImages(fileName: String) -> [UIImage] {
        var gifArray = [UIImage]()
        var i = 0
        var image = UIImage(named: "\(fileName)-\(i)")
        while (image != nil) {
            gifArray.append(image!)
            ++i
            image = UIImage(named: "\(fileName)-\(i)")
        }
        return gifArray
    }
    
    func playRandomGif() {
        // select random element from catGifNameArray
        let randomElement = catGifNameArray.first
        let images = gifAnimationImages(randomElement!)
        
        self.gifView.animationImages = images;
        self.gifView.animationDuration = 1.0
        self.gifView.startAnimating()
    }
}
