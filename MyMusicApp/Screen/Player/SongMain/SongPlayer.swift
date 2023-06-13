//
//  SongPlayer.swift
//  MyMusicApp
//
//  Created by Daniil Kulikovskiy on 12.06.2023.
//

import UIKit

class SongPlayer: UIViewController {
    
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
        label.textColor = CommonConstant.Color.greenPlayer
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
    
    private let shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(SongConstant.Symbol.share, for: .normal)
        return button
    }()
    
    private let addPlaylistButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(SongConstant.Symbol.add, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(SongConstant.Symbol.favourite, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(SongConstant.Symbol.download, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let progressBar: UIProgressView = {
        let prgressBar = UIProgressView(progressViewStyle: .default)
        prgressBar.translatesAutoresizingMaskIntoConstraints = false
        prgressBar.trackTintColor = CommonConstant.Color.greenPlayer
        prgressBar.tintColor = CommonConstant.Color.lightGray
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
        return button
    }()
    
    private lazy var backTrack: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(SongConstant.Symbol.backTrackButton, for: .normal)
        return button
    }()
    
    private lazy var playTrack: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(SongConstant.Symbol.playButton, for: .normal)
        button.backgroundColor = CommonConstant.Color.greenPlayer
        button.layer.cornerRadius = 36.5
        return button
    }()
    
    private lazy var nextTrack: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(SongConstant.Symbol.nextTrackButton, for: .normal)
        return button
    }()
    
    private lazy var repeatTrack: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(SongConstant.Symbol.repeatButton, for: .normal)
        return button
    }()
    
    private let navigationTrackStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        stack.axis = .horizontal
        stack.spacing = 5
        stack.distribution = .fillEqually
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CommonConstant.Color.playerBackground
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
        view.addSubview(navigationTrackStack)
        
        stackView.addArrangedSubview(shareButton)
        stackView.addArrangedSubview(addPlaylistButton)
        stackView.addArrangedSubview(favoriteButton)
        stackView.addArrangedSubview(downloadButton)
        
        navigationTrackStack.addArrangedSubview(shuffleTrack)
        navigationTrackStack.addArrangedSubview(backTrack)
        navigationTrackStack.addArrangedSubview(playTrack)
        navigationTrackStack.addArrangedSubview(nextTrack)
        navigationTrackStack.addArrangedSubview(repeatTrack)
        
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
            
//            playTrack.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 60),
//            playTrack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            playTrack.heightAnchor.constraint(equalToConstant: 73),
//            playTrack.widthAnchor.constraint(equalToConstant: 73)
            
            navigationTrackStack.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 40),
            navigationTrackStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 13),
            navigationTrackStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -13),
            navigationTrackStack.heightAnchor.constraint(equalToConstant: 80),
            
            playTrack.heightAnchor.constraint(equalToConstant: 73),
            playTrack.widthAnchor.constraint(equalToConstant: 73),
            
            
            
            
            
            
        ])
    }
    
}
