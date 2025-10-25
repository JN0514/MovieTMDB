//
//  YoutubePlayerVC.swift
//  MovieDB
//
//  Created by JAYA$URYA on 25/10/25.
//

import SwiftUI
import YouTubeiOSPlayerHelper

struct YouTubePlayer: UIViewRepresentable {
    let videoID: String
    @Binding var canPlayVideo: Bool

    func makeUIView(context: Context) -> YTPlayerView {
        let player = YTPlayerView()
        player.backgroundColor = .clear
        player.webView?.backgroundColor = .clear
        player.webView?.underPageBackgroundColor = .clear
        let swipeGesture = UISwipeGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.dismiss))
        swipeGesture.direction = .down
        player.addGestureRecognizer(swipeGesture)
        player.delegate = context.coordinator
        return player
    }

    func updateUIView(_ uiView: YTPlayerView, context: Context) {
        let playerVars: [String: Any] = [
            "autoplay": 1,
            "playsinline": 1,
            "rel": 0,
            "modestbranding": 1
        ]
        uiView.load(withVideoId: videoID, playerVars: playerVars)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, YTPlayerViewDelegate {
        var parent: YouTubePlayer
        init(_ parent: YouTubePlayer) {
            self.parent = parent
            super.init()
        }
        func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
            playerView.playVideo()
        }
        
        @objc func dismiss() {
            parent.canPlayVideo = false
        }
    }
}
