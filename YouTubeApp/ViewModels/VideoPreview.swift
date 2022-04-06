//
//  VideoPreview.swift
//  YouTubeApp
//
//  Created by David Newman on 4/5/22.
//

import Foundation
import Alamofire

class VideoPreview: ObservableObject {
    
    @Published var thumbnailData = Data()
    @Published var title: String
    @Published var date: String
    
    var video:Video
    
    init(video: Video){
        
        //Set Video and Title
        self.video =  video
        self.title = video.title
        //Set the Date
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d, yyyy"
        self.date = df.string(from: video.published)
        
        //Download the image data
        guard video.thumbnail != "" else{return}
        
        //Check cache before donwload
        if let cachedData = CacheManager.getVideoCache(video.thumbnail){
            //Set the thumbnail data
            thumbnailData = cachedData
            return
        }
        
        //Get URL from thumbnail
        guard let url = URL(string: video.thumbnail) else {return}
        
        //Create Request
        AF.request(url).validate().responseData { response in
            if let data = response.data {
                //Save data in cache
                CacheManager.setVideoCache(video.thumbnail, data)
                
                //Set image
                DispatchQueue.main.async {
                    self.thumbnailData = data
                }
            }
        }
    }
    
}
