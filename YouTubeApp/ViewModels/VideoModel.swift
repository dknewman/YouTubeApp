//
//  VideoModel.swift
//  YouTubeApp
//
//  Created by David Newman on 4/5/22.
//
import Foundation
import Alamofire

class VideoModel: ObservableObject {
    
    @Published var videos = [Video]()
    
    init() {
        getVideos()
    }
    
    func getVideos() {
        
        // Create a URL object
        guard let url = URL(string: "\(Constants.API_URL)/playlistItems") else {
            return
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        AF.request(
            url,
            parameters: ["part": "snippet", "playlistId": Constants.PLAYLIST_ID, "key": Constants.API_KEY]
        )
        .validate()
        .responseDecodable(of: Response.self, decoder: decoder) { response in
            
            // Check that the call was successful
            switch response.result {
            case .success:
                break
            case .failure(let error):
                print(error.localizedDescription)
                return
            }
            
            // Update the UI with the videos
            if let items = response.value?.items {
                DispatchQueue.main.async {
                    self.videos = items
                }
            }
        }
        
    }
    
}
