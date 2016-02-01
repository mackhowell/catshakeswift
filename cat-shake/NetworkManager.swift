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
    var video: Video?
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
        
        print(playlistURL)
        
        Alamofire.request(.GET, playlistURL)
            .responseJSON { response in
                let videoList = VideoList(json: response.result.value!)
//                print(videoList)
                completionClosure(list: videoList, error: nil)
            }
    }

}
