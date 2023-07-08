//
//  MediaView.swift
//  ProductHuntSwiftUI
//
//  Created by Alexis Bronchart on 18/09/2021.
//

import SwiftUI
import AVKit

struct MediaView: View {

    let medias: [Media]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 16) {
                ForEach(self.medias) { media in
                    MediaTile(media: media)
                }
            }
        }
    }
}

struct MediaTile: View {
    
    @Environment(\.windowBounds) var windowBounds

    let media: Media
    let padding = 16.0
    let mediaRatio = 16.0/9
    
    var body: some View {
        VStack {
            switch(self.media.type) {
            case "image":
                AsyncImage(url: URL(string: self.media.url)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
            case "video":
                Link(destination: URL(string: self.media.videoUrl ?? "")!) {
                    ZStack {
                        AsyncImage(url: URL(string: self.media.url)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        VStack {
                            Image(systemName: "play.circle")
                                .foregroundColor(.secondary)
                                .font(.system(size: 100))
                            Text("Play on YouTube")
                                .foregroundColor(.secondary)
                        }
                    }
                }
            default:
                Text("Unsupported media type")
            }
        }
        .frame(
            width: windowBounds.width - padding * 2,
            height: (windowBounds.width - padding * 2) / mediaRatio
        )
        .cornerRadius(4)
        .shadow(radius: 8)
        .padding(padding)
    }
}

struct MediaView_Previews: PreviewProvider {

    static let media1 = Media(id: "1", type: "image", url: "https://ph-files.imgix.net/e8480955-396f-4450-88d8-4cceb954d29d.png?auto=format&auto=compress&codec=mozjpeg&cs=strip&w=635&h=380&fit=max&dpr=2", videoUrl: nil)
    static let media2 = Media(id: "2", type: "video", url: "", videoUrl: "https://www.youtube.com/watch?v=PDVfV2hfHHs")

    static var previews: some View {
        MediaView(medias: [media1, media2])
    }
}
