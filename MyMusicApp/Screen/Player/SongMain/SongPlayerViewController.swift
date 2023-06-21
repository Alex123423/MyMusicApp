//
//  SongPlayerViewController.swift
//  MyMusicApp
//
//  Created by Daniil Kulikovskiy on 20.06.2023.
//

import UIKit
import AVKit
import AVFoundation
import Kingfisher

protocol TrackMovingDelegate: AnyObject {
    func moveBackForPreviewsTrack() -> TableViewCell
    func moveForwardForPreviewsTrack() -> TableViewCell
}

class SongPlayerViewController: UIViewController {
    
    var updateTimer: Timer?
    
    var currentAlbum: Album?
    
    private let playerManager = PlayerManager.shared
    private let musicManager = MusicManager.shared
    private let realmManager = RealmManager.shared
    
    
    let songPlayer = SongPlayer()
    weak var delegate: TrackMovingDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playStopForPlayer()
        
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
    
    func playStopForPlayer() {
        playerManager.playPauseStateChanged = { [weak self] isPlaying in
            guard let self = self else { return }
            let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 32, weight: .regular)
            let playSymbol = SongConstant.Symbol.playButton
            let pauseSymbol = SongConstant.Symbol.pauseButton
            if isPlaying {
                let updatedSymbol = pauseSymbol!.withConfiguration(symbolConfiguration)
                self.songPlayer.playTrack.setImage(updatedSymbol, for: .normal)
                //                self.songPlayer.progressBar.maximumValue = Float(playerManager.player?.currentItem?.duration.seconds ?? 0)
                self.bigImageView()
            } else {
                let updatedSymbol = playSymbol!.withConfiguration(symbolConfiguration)
                self.songPlayer.playTrack.setImage(updatedSymbol, for: .normal)
                self.smallImageView()
            }
        }
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
        songPlayer.playTrack.addTarget(self, action: #selector(playPauseTapped), for: .touchUpInside)
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
        //add to donwloads array
        let realmAlbum = RealmAlbumModel()
        if let trackSampleURLString = currentAlbum?.previewUrl {
            musicManager.downloadTrackSample(from: trackSampleURLString) { localURL in
                DispatchQueue.main.async {
                    if let localURL = localURL, let currentAlbumToSave = self.currentAlbum {
                        realmAlbum.artistName = currentAlbumToSave.artistName
                        realmAlbum.trackName = currentAlbumToSave.trackName
                        realmAlbum.artworkUrl60 = currentAlbumToSave.artworkUrl60
                        realmAlbum.previewUrl = currentAlbumToSave.previewUrl
                        realmAlbum.localFileUrl = localURL.absoluteString
                    }
                    
                    self.realmManager.saveRealmAlbum(realmAlbum: realmAlbum)
                    print("REALM ALBUM DATA: \(realmAlbum)")
                    print("REALM CURRENT USER DATA: \(self.realmManager.currentRealmUser)")
                    print("Track sample downloaded and saved at: \(localURL)")
                }
            }
        } else {
            print("Failed to download track sample.")
        }
    }

@objc func touchSlider() {
    //        if let player = player {
    //            player.pause()
    //            let currentTime = TimeInterval(songPlayer.progressBar.value)
    //            player.seek(to: CMTime(seconds: currentTime, preferredTimescale: 1))
    //            player.play()
    //        }
}
@objc func shuffleTracks() {
    print("Shuffle track")
}

@objc func playPauseTapped() {
    if let urlString = currentAlbum?.previewUrl,
       let url = URL(string: urlString) {
        playerManager.playPauseSong(trackURL: url)
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
    //        if let player = player {
    //            let currentTime = player.currentTime().seconds
    //            let duration = player.currentItem?.duration.seconds ?? 0
    //            songPlayer.progressBar.minimumValue = 0
    //            songPlayer.progressBar.maximumValue = Float(duration)
    //            songPlayer.progressBar.value = Float(currentTime)
    //        }
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
