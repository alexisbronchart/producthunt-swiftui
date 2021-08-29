//
//  MediaView.swift
//  ProductHuntSwiftUI
//
//  Created by Alexis Bronchart on 18/09/2021.
//

import SwiftUI
import AVKit
import XCDYouTubeKit

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

struct YoutubeVideo: View {

    let urlString: String?

    @State var videoURL: URL?
    @State var errorMessage: String?

    var body: some View {
        ZStack {
            if let url = self.videoURL {
                VideoPlayer(player: AVPlayer(url: url))
            }
            if let errorMessage = errorMessage {
                Text(errorMessage)
            }
        }
        .onAppear {
            Task {
                await self.loadVideo()
            }
        }
    }

    func loadVideo() async {
        guard let videoURL = self.urlString, let videoIdentifier = URL(string: videoURL )?.queryParams["v"] else {
            self.errorMessage = "Couldn't get video ID."
            return
        }
        let result = await XCDYouTubeClient.default().getVideo(with: videoIdentifier)
        switch(result) {
        case .success(let video):
            self.videoURL = video.streamURL
        case .failure(let error):
            self.errorMessage = error.localizedDescription
        }
    }
}

struct MediaTile: View {

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
                        Image(systemName: "play.circle")
                            .foregroundColor(.secondary)
                            .font(.system(size: 100))
                    }
                }
                // this was an attempt to read youtube videos using XCDYouTubeKit but it doesn't seem to be a viable option
                // YoutubeVideo(urlString: self.media.videoUrl)
            default:
                Text("Unsupported media type")
            }
        }
        .frame(width: UIScreen.main.bounds.width - padding * 2, height: (UIScreen.main.bounds.width - padding * 2) / mediaRatio )
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
