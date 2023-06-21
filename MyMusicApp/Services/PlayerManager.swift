//
//  PlayerManager.swift
//  MyMusicApp
//
//  Created by Vitali Martsinovich on 2023-06-21.
//

import Foundation
import AVFoundation
import AVKit

final class PlayerManager {
    
    static let shared = PlayerManager()
    private init() { }
    
    var localPlayer: AVAudioPlayer?
    var player: AVPlayer?

    var playPauseStateChanged: ((Bool) -> Void)?
    
    func playTrackSampleFromLocal(at fileURL: URL) {
            print("play")
            DispatchQueue.main.async {
                do {
                    self.localPlayer = try AVAudioPlayer(contentsOf: fileURL)
                    self.localPlayer?.prepareToPlay()
                    self.localPlayer?.play()
                } catch {
                    print("Error playing track sample: \(error.localizedDescription)")
                }
            }
        }
    
    func playPauseSong(trackURL: URL) {
//        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 32, weight: .regular)
//        let playSymbol = SongConstant.Symbol.playButton
//        let pauseSymbol = SongConstant.Symbol.pauseButton
        
        if let player = player, player.rate != 0 {
            // Player is currently playing, pause playback
            print("Music paused.")
            player.pause()
            playPauseStateChanged?(false)
//            let updatedSymbol = playSymbol!.withConfiguration(symbolConfiguration)
//            songPlayer.playTrack.setImage(updatedSymbol, for: .normal)
//            smallImageView()
        } else {
            // Player is currently paused or not initialized, start playback
            let playerItem = AVPlayerItem(url: trackURL)
            player = AVPlayer(playerItem: playerItem)
            player?.play()
            playPauseStateChanged?(true)
            print("Music started playing.")
//            let updatedSymbol = pauseSymbol!.withConfiguration(symbolConfiguration)
//            songPlayer.playTrack.setImage(updatedSymbol, for: .normal)
//            songPlayer.progressBar.maximumValue = Float(player?.currentItem?.duration.seconds ?? 0)
//            bigImageView()
        }
    }
}
    
