//
//  NetworkManager.swift
//  cat-shake
//
//  Created by Mack on 1/31/16.
//  Copyright © 2016 Mack. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

struct VideoList {
    var arrayOfVideos: [Video] = []
    
    init(json: AnyObject) {
        let json = JSON(json)
        let items = json["items"].array
        if let itemList = items {
            for item in itemList {
                let video = Video(json: item)
                arrayOfVideos.append(video)
            }
        }
    }
    
    mutating func randomVideo(currentVideo: Video?) -> Video {
        let randomIndex = Int(arc4random_uniform(UInt32(arrayOfVideos.count)))
        let randomVid = arrayOfVideos[randomIndex]
        
        guard let currVid = currentVideo else {
            return randomVid
        }
        
        if randomVid.id == currVid.id {
            randomVideo(currentVideo)
        }
        arrayOfVideos.removeAtIndex(randomIndex)
        print("videos left to watch = \(arrayOfVideos.count)")
        return randomVid
    }
}

struct Video {
    var id: String?
    
    init(json: JSON) {
        if let id = json["contentDetails"].dictionary {
            self.id = id["videoId"]?.string
        }
    }
}

struct NetworkManager {
    
    typealias getPlaylistCompletionBlock = (list: VideoList, error: NSError?) -> ()
    
    static func getYoutubePlaylist(completionClosure: getPlaylistCompletionBlock) {
        
        let file = NSBundle.mainBundle().pathForResource("keys", ofType: "plist")
        guard let keysFile = file else {
            print("keys file not found")
            return
        }
        let fileArray = NSArray(contentsOfFile: keysFile)
        
        guard let url = fileArray?.firstObject as? String else {
            return
        }
        let ytURL = NSURL(string: url)
        guard let playlistURL = ytURL else {
            return
        }
        
        print("*** getting playlist from \(playlistURL)**")
        
        Alamofire.request(.GET, playlistURL)
            .responseJSON { response in
                let videoList = VideoList(json: response.result.value!)
                completionClosure(list: videoList, error: nil)
            }
    }

}
