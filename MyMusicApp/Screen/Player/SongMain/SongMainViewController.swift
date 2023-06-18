//
//  SongPlayer.swift
//  MyMusicApp
//
//  Created by Daniil Kulikovskiy on 12.06.2023.
//

import UIKit
import AVFoundation

class SongPlayer: UIViewController {
    
    var player: AVAudioPlayer!
    
    private var pictureSong: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "songImage")
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 120
        return image
    }()
    
    private let songTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Come to me"
        label.font = .boldSystemFont(ofSize: 36)
        label.textColor = .white
        return label
    }()
    
    private let artistTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "One Republic"
        label.textColor = .white
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    private let albumTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "It is a long established fact that a reader"
        label.textColor = .maCustomYellow
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        stack.axis = .horizontal
        stack.spacing = 5
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(SongConstant.Symbol.share, for: .normal)
        button.addTarget(self, action: #selector(tapShare), for: .touchUpInside)
        return button
    }()
    
    @objc func tapShare() {
        print("Tap Share")
    }
    
    private lazy var addPlaylistButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(SongConstant.Symbol.add, for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(addPlaylist), for: .touchUpInside)
        return button
    }()
    
    @objc func addPlaylist() {
        print("add playlist")
    }
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(SongConstant.Symbol.favourite, for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(tapLike), for: .touchUpInside)
        return button
    }()
    
    @objc func tapLike() {
        print("Tap to like")
    }
    
    private lazy var downloadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(SongConstant.Symbol.download, for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(tapDownload), for: .touchUpInside)
        return button
    }()
    
    @objc func tapDownload() {
        print("Tap to Download")
    }
    
    private let progressBar: UIProgressView = {
        let prgressBar = UIProgressView(progressViewStyle: .bar)
        prgressBar.translatesAutoresizingMaskIntoConstraints = false
        prgressBar.trackTintColor = .maCustomYellow
        prgressBar.tintColor = .maLightGray
        return prgressBar
    }()
    
    private let startSongTimer: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0:00"
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let endSongTimer: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "3:05"
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var shuffleTrack: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(SongConstant.Symbol.shuffleButton, for: .normal)
        button.addTarget(self, action: #selector(shuffleSong), for: .touchUpInside)
        return button
    }()
    
    @objc func shuffleSong() {
        print("Shuffle track")
    }
    
    private lazy var backTrack: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(SongConstant.Symbol.backTrackButton, for: .normal)
        button.addTarget(self, action: #selector(tapToBack), for: .touchUpInside)
        return button
    }()
    
    @objc func tapToBack() {
        print("Tap To Back")
    }
    
    private lazy var playTrack: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 32, weight: .regular)
        let playSymbol = SongConstant.Symbol.playButton
        let updatedSymbol = playSymbol!.withConfiguration(symbolConfiguration)
        button.setImage(updatedSymbol, for: .normal)
        button.backgroundColor = .maCustomYellow
        button.layer.cornerRadius = 36.5
        button.tintColor = .black
        button.imageView?.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        button.layer.shadowColor = UIColor(named: "CommonConstant.Color.greenPlayer")?.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowRadius = 10
        button.addTarget(self, action: #selector(playPauseSong), for: .touchUpInside)
        return button
    }()
    
    @objc func playPauseSong() {
        let url = Bundle.main.url(forResource: "StayinAlive", withExtension: "mp3")
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 32, weight: .regular)
        let playSymbol = SongConstant.Symbol.playButton
        let pauseSymbol = SongConstant.Symbol.pauseButton
        
        
        if player == nil {
                // Инициализация плеера только при первом нажатии
                player = try! AVAudioPlayer(contentsOf: url!)
                player.prepareToPlay()
                player.play()
                print("Music started playing.")
                    let updatedSymbol = pauseSymbol!.withConfiguration(symbolConfiguration)
                    playTrack.setImage(updatedSymbol, for: .normal)
            } else {
                if player.isPlaying {
                    print("Music paused.")
                    let updatedSymbol = playSymbol!.withConfiguration(symbolConfiguration)
                    playTrack.setImage(updatedSymbol, for: .normal)
                    player.pause()
                } else {
                    print("Music resumed playing.")
                    let updatedSymbol = pauseSymbol!.withConfiguration(symbolConfiguration)
                    playTrack.setImage(updatedSymbol, for: .normal)
                    player.play()
                }
            }
        }
    
    private lazy var nextTrack: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(SongConstant.Symbol.nextTrackButton, for: .normal)
        button.addTarget(self, action: #selector(nextSong), for: .touchUpInside)
        return button
    }()
    
    @objc func nextSong() {
        print("Next Song")
    }
    
    private lazy var repeatTrack: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(SongConstant.Symbol.repeatButton, for: .normal)
        button.addTarget(self, action: #selector(repeatSong), for: .touchUpInside)
        return button
    }()
    
    @objc func repeatSong() {
        print("Repeat Song")
    }
    
    private let navigationTrackStackLeft: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let navigationTrackStackRight: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .maBackground
        progressBar.setProgress(0.5, animated: false)
        progressBar.transform = CGAffineTransform(scaleX: 1.0, y: 0.5)
        layout()
    }
    
    func layout() {
        
        view.addSubview(pictureSong)
        view.addSubview(songTitle)
        view.addSubview(artistTitle)
        view.addSubview(albumTitle)
        view.addSubview(stackView)
        view.addSubview(progressBar)
        view.addSubview(startSongTimer)
        view.addSubview(endSongTimer)
        view.addSubview(playTrack)
        view.addSubview(navigationTrackStackLeft)
        view.addSubview(navigationTrackStackRight)
        
        stackView.addArrangedSubview(shareButton)
        stackView.addArrangedSubview(addPlaylistButton)
        stackView.addArrangedSubview(favoriteButton)
        stackView.addArrangedSubview(downloadButton)
        
        navigationTrackStackLeft.addArrangedSubview(shuffleTrack)
        navigationTrackStackLeft.addArrangedSubview(backTrack)
        
        navigationTrackStackRight.addArrangedSubview(nextTrack)
        navigationTrackStackRight.addArrangedSubview(repeatTrack)
        
        NSLayoutConstraint.activate([
            
            pictureSong.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pictureSong.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            pictureSong.heightAnchor.constraint(equalToConstant: 240),
            pictureSong.widthAnchor.constraint(equalToConstant: 240),
            
            songTitle.topAnchor.constraint(equalTo: pictureSong.bottomAnchor, constant: 20),
            songTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            artistTitle.topAnchor.constraint(equalTo: songTitle.bottomAnchor, constant: 8),
            artistTitle.centerXAnchor.constraint(equalTo: songTitle.centerXAnchor),
            
            albumTitle.topAnchor.constraint(equalTo: artistTitle.bottomAnchor, constant: 30),
            albumTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: albumTitle.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 30),
            
            progressBar.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 40),
            progressBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 23),
            progressBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -23),
            
            startSongTimer.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 13),
            startSongTimer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 23),
            
            endSongTimer.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 13),
            endSongTimer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -23),
            
            playTrack.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 60),
            playTrack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playTrack.heightAnchor.constraint(equalToConstant: 73),
            playTrack.widthAnchor.constraint(equalToConstant: 73),
            
            navigationTrackStackLeft.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationTrackStackLeft.trailingAnchor.constraint(equalTo: playTrack.leadingAnchor, constant: -10),
            navigationTrackStackLeft.centerYAnchor.constraint(equalTo: playTrack.centerYAnchor),
            
            shuffleTrack.heightAnchor.constraint(equalToConstant: 40),
            backTrack.heightAnchor.constraint(equalToConstant: 40),

            navigationTrackStackRight.leadingAnchor.constraint(equalTo:  playTrack.trailingAnchor, constant: 10),
            navigationTrackStackRight.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationTrackStackRight.centerYAnchor.constraint(equalTo: playTrack.centerYAnchor),
            
            nextTrack.heightAnchor.constraint(equalToConstant: 40),
            repeatTrack.heightAnchor.constraint(equalToConstant: 40)
            
        ])
    }
    
}
