//
//  SongPlayerViewController.swift
//  MyMusicApp
//
//  Created by Daniil Kulikovskiy on 20.06.2023.
//

import UIKit
import AVFoundation
import Kingfisher

protocol TrackMovingDelegate: AnyObject {
    func moveBackForPreviewsTrack() -> TableViewCell
    func moveForwardForPreviewsTrack() -> TableViewCell
}

class SongPlayerViewController: UIViewController {
    
    var player: AVAudioPlayer!
    var updateTimer: Timer?
    
    let songPlayer = SongPlayer()
    weak var delegate: TrackMovingDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = songPlayer
        songPlayer.backgroundColor = .maBackground
        songPlayer.layout()
        smallImageView()
        targetActionBar()
        targetForNavigation()
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(monitorPlayerTime), userInfo: nil, repeats: true)
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
            swipeGesture.direction = .down
            view.addGestureRecognizer(swipeGesture)
    }
    
    func targetActionBar() {
        songPlayer.shareButton.addTarget(self, action: #selector(tapShare), for: .touchUpInside)
        songPlayer.addPlaylistButton.addTarget(self, action: #selector(addPlaylist), for: .touchUpInside)
        songPlayer.favoriteButton.addTarget(self, action: #selector(tapLike), for: .touchUpInside)
        songPlayer.downloadButton.addTarget(self, action: #selector(tapDownload), for: .touchUpInside)
        songPlayer.progressBar.addTarget(self, action: #selector(touchSlider), for: .valueChanged)
    }
    
    func targetForNavigation() {
        songPlayer.shuffleTrack.addTarget(self, action: #selector(shuffleTracks), for: .touchUpInside)
        songPlayer.previousTrack.addTarget(self, action: #selector(previousTrack), for: .touchUpInside)
        songPlayer.playTrack.addTarget(self, action: #selector(playPauseSong), for: .touchUpInside)
        songPlayer.nextTrack.addTarget(self, action: #selector(nextTrack), for: .touchUpInside)
        songPlayer.repeatTrack.addTarget(self, action: #selector(repeatTrack), for: .touchUpInside)
    }
    
    @objc func handleSwipeGesture(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .down {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func tapShare() {
        print("Tap Share")
        let share = UIActivityViewController(activityItems: ["Son"], applicationActivities: nil)
        present(share, animated: true)
    }
    
    @objc func addPlaylist() {
        print("add playlist")
    }
    
    @objc func tapLike() {
        print("tap like")
    }
    
    @objc func tapDownload() {
        print("Tap to Download")
    }
    
    @objc func touchSlider() {
        player.stop()
        player.currentTime = TimeInterval(songPlayer.progressBar.value)
        player.prepareToPlay()
        player.play()
    }
    
    @objc func shuffleTracks() {
        print("Shuffle track")
    }
    
    @objc func playPauseSong() {
        let url = Bundle.main.url(forResource: "StayinAlive", withExtension: "mp3")
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 32, weight: .regular)
        let playSymbol = SongConstant.Symbol.playButton
        let pauseSymbol = SongConstant.Symbol.pauseButton
        
        if player == nil {
                // Инициализация плеера только при первом нажатии
                player = try! AVAudioPlayer(contentsOf: url!)
//                player.delegate = self
                player.prepareToPlay()
                player.play()
                print("Music started playing.")
                    let updatedSymbol = pauseSymbol!.withConfiguration(symbolConfiguration)
                songPlayer.playTrack.setImage(updatedSymbol, for: .normal)
            songPlayer.progressBar.maximumValue = Float(player.duration)
            bigImageView()
            } else {
                if player.isPlaying {
                    print("Music paused.")
                    let updatedSymbol = playSymbol!.withConfiguration(symbolConfiguration)
                    songPlayer.playTrack.setImage(updatedSymbol, for: .normal)
                    player.pause()
                    smallImageView()
                    
                } else {
                    print("Music resumed playing.")
                    let updatedSymbol = pauseSymbol!.withConfiguration(symbolConfiguration)
                    songPlayer.playTrack.setImage(updatedSymbol, for: .normal)
                    player.play()
                    bigImageView()
                   
                }
            }
        }
    
    func configureSongPlayerView(sender: Album) {
        songPlayer.artistTitle.text = sender.artistName
        songPlayer.songTitle.text = sender.trackName
        let UirlString600 = (sender.artworkUrl60?.replacingOccurrences(of: "60x60", with: "600x600"))!
        guard let artworkURL = URL(string: UirlString600) else { return }
        songPlayer.pictureSong.kf.setImage(with: artworkURL)
    }
    
    @objc func previousTrack() {
        print("Tap To Back")
    }
    
    @objc func nextTrack() {
        let cell = delegate?.moveForwardForPreviewsTrack
        
        print("Next Song")
    }
    
    @objc func repeatTrack() {
        print("Repeat Song")
    }
    
    @objc func monitorPlayerTime() {
        songPlayer.progressBar.value = Float(player?.currentTime ?? 0)

    }
    
    
    //MARK: - Animations
    func bigImageView() {
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 1,
                       options: .curveEaseInOut) {
            let scale: CGFloat = 1.1
            self.songPlayer.pictureSong.transform = CGAffineTransform(scaleX: scale, y: scale)
            
        }
    }
    
    func smallImageView() {
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 1,
                       options: .curveEaseInOut) {
            self.songPlayer.pictureSong.transform = .identity
        }
    }
}
