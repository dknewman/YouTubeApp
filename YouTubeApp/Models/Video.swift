//
//  Video.swift
//  YouTubeApp
//
//  Created by David Newman on 4/4/22.
//

import Foundation
struct Video: Decodable {
    
    var videoId = ""
    var title = ""
    var description = ""
    var thumbnail = ""
    var published = Date()
    
    enum CodingKeys: String, CodingKey {
        
        case snippet
        case thumbnails
        case high
        case resourceId
        case published = "publishedAt"
        case title
        case description
        case thumbnail = "url"
        case videoId
    }
    
    init(){
        self.videoId = "1234567890"
        self.title = "Fake Video"
        self.description = "Sample description to show in the UI."
        self.thumbnail = "https://yt3.ggpht.com/584JjRp5QMuKbyduM_2k5RlXFqHJtQ0qLIPZpwbUjMJmgzZngHcam5JMuZQxyzGMV5ljwJRl0Q=s900-c-k-c0x00ffffff-no-rj"
        self.published = Date()
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let snippetContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .snippet)
        
        //Parse Title
        self.title = try snippetContainer.decode(String.self, forKey: .title)
        
        //Parse desc
        self.description = try snippetContainer.decode(String.self, forKey: .description)
        //Parse Published date
        self.published = try snippetContainer.decode(Date.self, forKey: .published)
        //Parse Thumbnail
        let thumbnailContainter = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .thumbnails)
        
        let hightContainer = try thumbnailContainter.nestedContainer(keyedBy: CodingKeys.self, forKey: .high)
        self.thumbnail = try hightContainer.decode(String.self, forKey: .thumbnail)
        
        //parse video ID
        
        let resourceIdContainter = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .resourceId)
        self.videoId = try resourceIdContainter.decode(String.self, forKey: .videoId)
    }
}
