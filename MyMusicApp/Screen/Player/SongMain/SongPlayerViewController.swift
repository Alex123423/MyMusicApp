//
//  SongPlayerViewController.swift
//  MyMusicApp
//
//  Created by Daniil Kulikovskiy on 20.06.2023.
//

import UIKit
import AVKit
import Kingfisher

protocol TrackMovingDelegate: AnyObject {
    func moveBackForPreviewsTrack() -> Album?
    func moveForwardForPreviewsTrack() -> Album?
}

class SongPlayerViewController: UIViewController {
    
    let player: AVPlayer = {
        let avPlayer = AVPlayer()
        avPlayer.automaticallyWaitsToMinimizeStalling = false
        return avPlayer
    }()
    
    var updateTimer: Timer?
    var currentAlbum: Album?
    var prewiewUrlTrack = ""
    let playSymbol = SongConstant.Symbol.playButton
    let pauseSymbol = SongConstant.Symbol.pauseButton
    var liked: Bool = false
    
    private let musicManager = MusicManager.shared
    private let realmManager = RealmManager.shared
    private let playerManager = PlayerManager.shared
    
    let songPlayer = SongPlayer()
    weak var delegate: TrackMovingDelegate?
    private let notificationCenter = NotificationsManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = songPlayer
        songPlayer.backgroundColor = .maBackground
        songPlayer.layout()
        smallImageView()
        targetActionBar()
        targetForNavigation()
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeGesture.direction = .down
        view.addGestureRecognizer(swipeGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        changeLikeButtonState()
        downloadButtonState()
    }
    
    func changeLikeButtonState() {
        if let trackName = currentAlbum?.trackName {
            let isFavorite = realmManager.isAlbumFavorite(trackName: trackName)
            let favoriteButtonImage = isFavorite ? SongConstant.Symbol.favouriteTapped : SongConstant.Symbol.favourite
            songPlayer.favoriteButton.setImage(favoriteButtonImage, for: .normal)
            liked = isFavorite
        }
    }
    
    func downloadButtonState() {
        if let trackName = currentAlbum?.trackName {
            let isDownloaded = realmManager.isAlbumDownloaded(trackName: trackName)
            let buttonColor: UIColor = isDownloaded ? .green : .white
            songPlayer.downloadButton.tintColor = buttonColor
            songPlayer.downloadButton.isUserInteractionEnabled = !isDownloaded
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
        songPlayer.playTrack.addTarget(self, action: #selector(playPause), for: .touchUpInside)
        songPlayer.nextTrack.addTarget(self, action: #selector(nextTrack), for: .touchUpInside)
        songPlayer.repeatTrack.addTarget(self, action: #selector(repeatTrack), for: .touchUpInside)
    }
    
    @objc func handleSwipeGesture(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .down {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func tapShare() {
        let share = UIActivityViewController(activityItems: [prewiewUrlTrack], applicationActivities: nil)
        present(share, animated: true)
    }
    
    @objc func addPlaylist() {
        print("add playlist")
    }
    
    @objc func tapLike() {
        if liked {
            songPlayer.favoriteButton.setImage(SongConstant.Symbol.favourite, for: .normal)
            liked = false
            if let trackName = currentAlbum?.trackName {
                do {
                    try realmManager.deleteFavoriteFromRealm(trackToDelete: trackName)
                } catch {
                    print("Error deleting track from Realm: \(error.localizedDescription)")
                }
            }
        } else {
            songPlayer.favoriteButton.setImage(SongConstant.Symbol.favouriteTapped, for: .normal)
            liked = true
            if let favouriteAlbum = currentAlbum {
                do {
                    try realmManager.saveFavouriteToRealm(albumToSave: favouriteAlbum)
                } catch {
                    print("Error saving track to Realm: \(error.localizedDescription)")
                }
            }
        }
    }
    
    @objc func tapDownload() {
        guard let currentAlbum = currentAlbum else {
            print("No album selected.")
            return
        }
        let isAlbumSaved = realmManager.isAlbumSaved(currentAlbum)
        if let localFileURLString = realmManager.getLocalFileURLString(for: currentAlbum) {
            let localFileURL = URL(fileURLWithPath: localFileURLString)
            if FileManager.default.fileExists(atPath: localFileURL.path) {
                print("Album already exists in local storage.")
                return
            }
        }
        if isAlbumSaved {
            print("Album already saved.")
            return
        }
        if let trackSampleURLString = currentAlbum.previewUrl {
            musicManager.downloadTrackSample(from: trackSampleURLString) { [weak self] localURL in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    let isAlbumSaved = self.realmManager.isAlbumSaved(currentAlbum)
                    if let localURL = localURL, !isAlbumSaved {
                        let realmAlbum = self.realmManager.createRealmAlbum(album: currentAlbum)
                        realmAlbum.localFileUrl = localURL.absoluteString
                        self.realmManager.saveRealmAlbum(albumToSave: realmAlbum)
                    }
                    self.downloadButtonState()
                }
                //notification call
                self?.notificationCenter.checkAuthorization { isAuthorized in
                    if isAuthorized {
                        self?.notificationCenter.scheduleNotification(titleText: currentAlbum.trackName ?? "Your", bodyText: currentAlbum.artistName ?? "Unknow artist")
                    }
                }
            }
        } else {
            print("Failed to download track sample.")
        }
    }

    
    @objc func touchSlider() {
        let time = CMTime(seconds: Double(songPlayer.progressBar.value), preferredTimescale: 1000)
        player.seek(to: time) { _ in
        }
    }
    
    @objc func shuffleTracks() {
        print("Shuffle track")
    }
    
    func configureSongPlayerView(sender: Album) {
        songPlayer.artistTitle.text = sender.artistName
        songPlayer.songTitle.text = sender.trackName
        print("configure called")
        if let localFileURLString = realmManager.getLocalFileURLString(for: sender) {
            playTrack(prewiewUrl: localFileURLString)
            print("PLAY FROM LOCAL")
        } else {
            print("PLAY FROM URL")
            playTrack(prewiewUrl: sender.previewUrl)
        }
//        playTrack(prewiewUrl: sender.previewUrl)
        prewiewUrlTrack = sender.previewUrl ?? ""
        guard let UirlString600 = (sender.artworkUrl60?.replacingOccurrences(of: "60x60", with: "600x600")) else { return }
        guard let artworkURL = URL(string: UirlString600) else { return }
        songPlayer.pictureSong.kf.setImage(with: artworkURL)
    }
    
    func playTrack(prewiewUrl: String?) {
        print("playtrack called")
        guard let url = URL(string: prewiewUrl ?? "") else { return }
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        asyncscheduledTimer()
        player.play()
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 32, weight: .regular)
        let updatedSymbol = pauseSymbol!.withConfiguration(symbolConfiguration)
        songPlayer.playTrack.setImage(updatedSymbol, for: .normal)
    }
    
    @objc func playPause() {
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 32, weight: .regular)
        player.volume = 0.7
        if player.timeControlStatus == .paused {
            player.play()
            print("Music resumed playing.")
            let updatedSymbol = pauseSymbol!.withConfiguration(symbolConfiguration)
            songPlayer.playTrack.setImage(updatedSymbol, for: .normal)
            bigImageView()
        } else if player.timeControlStatus == .playing {
            player.pause()
            print("Music paused.")
            let updatedSymbol = playSymbol!.withConfiguration(symbolConfiguration)
            songPlayer.playTrack.setImage(updatedSymbol, for: .normal)
            smallImageView()
        }
    }
    
    @objc func updateProgressBar() {
        let currentTime = player.currentTime().seconds
        let duration = player.currentItem?.duration.seconds ?? 0
        songPlayer.progressBar.value = Float(currentTime)
        songPlayer.progressBar.maximumValue = Float(duration)
    }
    
    @objc func previousTrack() {
        let cell = delegate?.moveBackForPreviewsTrack()
        guard let cellCheck = cell else { return }
        configureSongPlayerView(sender: cellCheck)
    }
    
    @objc func nextTrack() {
        let cell = delegate?.moveForwardForPreviewsTrack()
        guard let cellCheck = cell else { return }
        configureSongPlayerView(sender: cellCheck)
    }
    
    @objc func repeatTrack() {
        print("Repeat Song")
    }
    
    //MARK: - Time Setup
    
    private func playerTime() {
        let time = CMTimeMake(value: 1, timescale: 3)
        let times = [NSValue(time: time)]
        player.addBoundaryTimeObserver(forTimes: times, queue: .main) { [weak self] in
            self?.bigImageView()
        }
    }
    
    func asyncscheduledTimer(){
        DispatchQueue.main.async {
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] timer in
                self?.monitorPlayerTime()
            }
        }
    }
    
    
    @objc func monitorPlayerTime() {
        guard let currentItem = player.currentItem else { return }
        
        let duration = currentItem.asset.duration.seconds
        let currentTime = currentItem.currentTime().seconds
        songPlayer.progressBar.maximumValue = Float(duration)
        songPlayer.progressBar.value = Float(currentTime)
        
        let formattedCurrentTime = formatTime(currentTime)
        let formattedDuration = formatTime(duration)
        songPlayer.startSongTimer.text = formattedCurrentTime
        songPlayer.endSongTimer.text = formattedDuration
        
    }
    
    func formatTime(_ time: Double) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
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
