//
//  CacheManager.swift
//  YouTubeApp
//
//  Created by David Newman on 4/5/22.
//

import Foundation

class CacheManager {
    
    static var cache = [String:Data]()
    
    static func setVideoCache(_ url: String, _ data: Data?){
        //Store the image data
        cache[url] = data
    }
    
    static func getVideoCache(_ url: String) -> Data?{
        //Request the data
        return cache[url]
    }
}
