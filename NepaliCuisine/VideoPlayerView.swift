//
//  VideoPlayerView.swift
//  NepaliCuisine
//
//  Created by Sajan Shrestha on 1/1/21.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    
    var url: String
    
    var body: some View {
        let player = AVPlayer(url: URL(string: url)!)
        
        return VideoPlayer(player: player)
            .aspectRatio(contentMode: .fill)
            .frame(height: 250)
            .onAppear {
                player.play()
                player.isMuted = true
            }
            .onDisappear {
                player.pause()
            }
    }
}

struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerView(url: "")
    }
}
