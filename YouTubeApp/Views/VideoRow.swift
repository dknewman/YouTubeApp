//
//  VideoRow.swift
//  YouTubeApp
//
//  Created by David Newman on 4/5/22.
//

import SwiftUI

struct VideoRow: View {
    @ObservedObject var videoPreview:VideoPreview
    @State private var isPresenting = false
    @State private var imageHeight: CGFloat = 0
    
    var body: some View {
        Button {
            isPresenting = true
            
        } label: {
            VStack(alignment: .leading, spacing: 10){
                //Display Thumbnail IMage
                GeometryReader{ geometry in
                    Image(uiImage: UIImage(data: videoPreview.thumbnailData) ?? UIImage())
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.width * 9 / 16)
                        .clipped()
                        .onAppear{
                            //Update the image height
                            imageHeight = geometry.size.width * 9 / 16
                        }
                }.frame(height: imageHeight)
                
                //Display Video Title
                Text(videoPreview.title)
                    .bold()
                //Display Video Date
                Text(videoPreview.date)
                    .foregroundColor(.gray)
            }.font(.system(size: 19))
            
        }.sheet(isPresented: $isPresenting) {
            VideoDetail(video: videoPreview.video
            )
        }
    }
}

struct VideoRow_Previews: PreviewProvider {
    static var previews: some View {
        VideoRow(videoPreview: VideoPreview(video: Video()))
    }
}
