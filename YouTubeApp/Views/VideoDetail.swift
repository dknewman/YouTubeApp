//
//  VideoDetail.swift
//  YouTubeApp
//
//  Created by David Newman on 4/5/22.
//

import SwiftUI

struct VideoDetail: View {
    var video:Video
    
    var date:String{
        //Format the date from video date
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d, yyyy"
        return df.string(from: video.published)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            //Display Video Title
            Text(video.title)
                .bold()
            //Display Date
            Text(date)
                .foregroundColor(.gray)
            //Display video
            YouTubeVideoPlayer(video: video)
                .aspectRatio(CGSize(width: 1280, height: 720), contentMode: .fit)
            //Display Description
            ScrollView{
                Text(video.description)
            }
        }.font(.system(size: 19))
            .padding()
            .padding(.top, 40)
            .background(backgroundColor.edgesIgnoringSafeArea(.all))
    }
}

struct VideoDetail_Previews: PreviewProvider {
    static var previews: some View {
        VideoDetail(video: Video())
    }
}
