//
//  YouTubeVideoPlayer.swift
//  YouTubeApp
//
//  Created by David Newman on 4/5/22.
//

import SwiftUI
import WebKit

struct YouTubeVideoPlayer: UIViewRepresentable {
    var video: Video
    func makeUIView(context: Context) -> some UIView {
        
        //Create Webview
        let view = WKWebView()
        view.backgroundColor = UIColor(backgroundColor)
        //Create URL
        let embedUrlString = Constants.YT_EMBED_URL + video.videoId
        //Load Video
        let url = URL(string: embedUrlString)
        let request = URLRequest(url: url!)
        view.load(request)
        //Return Webview
        return view
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

struct YouTubeVideoPlayer_Previews: PreviewProvider {
    static var previews: some View {
        YouTubeVideoPlayer(video: Video())
    }
}
