//
//  SongPlayer.swift
//  MyMusicApp
//
//  Created by Daniil Kulikovskiy on 12.06.2023.
//

import UIKit
import AVFoundation

class SongPlayer: UIView {
    
    let pictureSong: UIImageView = {
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
    
    let shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(SongConstant.Symbol.share, for: .normal)
        return button
    }()
    
    let addPlaylistButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(SongConstant.Symbol.add, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    let favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(SongConstant.Symbol.favourite, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    let downloadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(SongConstant.Symbol.download, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    let progressBar: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.tintColor = .maCustomYellow
        return slider
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
    
    let shuffleTrack: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(SongConstant.Symbol.shuffleButton, for: .normal)
        return button
    }()
    
    
    let backTrack: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(SongConstant.Symbol.backTrackButton, for: .normal)
        return button
    }()
    
    let playTrack: UIButton = {
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
        return button
    }()
    
    
    let nextTrack: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(SongConstant.Symbol.nextTrackButton, for: .normal)
        return button
    }()
    
    let repeatTrack: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(SongConstant.Symbol.repeatButton, for: .normal)
        return button
    }()
    
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
}
    
    
    //MARK: - Layout
    
extension SongPlayer {
        
        func layout() {
            
            self.addSubview(pictureSong)
            self.addSubview(songTitle)
            self.addSubview(artistTitle)
            self.addSubview(albumTitle)
            self.addSubview(stackView)
            self.addSubview(progressBar)
            self.addSubview(startSongTimer)
            self.addSubview(endSongTimer)
            self.addSubview(playTrack)
            self.addSubview(navigationTrackStackLeft)
            self.addSubview(navigationTrackStackRight)
            
            stackView.addArrangedSubview(shareButton)
            stackView.addArrangedSubview(addPlaylistButton)
            stackView.addArrangedSubview(favoriteButton)
            stackView.addArrangedSubview(downloadButton)
            
            navigationTrackStackLeft.addArrangedSubview(shuffleTrack)
            navigationTrackStackLeft.addArrangedSubview(backTrack)
            
            navigationTrackStackRight.addArrangedSubview(nextTrack)
            navigationTrackStackRight.addArrangedSubview(repeatTrack)
            
            NSLayoutConstraint.activate([
                
                pictureSong.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                pictureSong.topAnchor.constraint(equalTo: self.topAnchor, constant: 160),
                pictureSong.heightAnchor.constraint(equalToConstant: 240),
                pictureSong.widthAnchor.constraint(equalToConstant: 240),
                
                songTitle.topAnchor.constraint(equalTo: pictureSong.bottomAnchor, constant: 25),
                songTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                
                artistTitle.topAnchor.constraint(equalTo: songTitle.bottomAnchor, constant: 8),
                artistTitle.centerXAnchor.constraint(equalTo: songTitle.centerXAnchor),
                
                albumTitle.topAnchor.constraint(equalTo: artistTitle.bottomAnchor, constant: 30),
                albumTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                
                stackView.topAnchor.constraint(equalTo: albumTitle.bottomAnchor, constant: 40),
                stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
                stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
                stackView.heightAnchor.constraint(equalToConstant: 30),
                
                progressBar.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 40),
                progressBar.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                progressBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 23),
                progressBar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -23),
                
                startSongTimer.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 13),
                startSongTimer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 23),
                
                endSongTimer.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 13),
                endSongTimer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -23),
                
                playTrack.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 40),
                playTrack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                playTrack.heightAnchor.constraint(equalToConstant: 73),
                playTrack.widthAnchor.constraint(equalToConstant: 73),
                
                navigationTrackStackLeft.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                navigationTrackStackLeft.trailingAnchor.constraint(equalTo: playTrack.leadingAnchor, constant: -10),
                navigationTrackStackLeft.centerYAnchor.constraint(equalTo: playTrack.centerYAnchor),
                
                shuffleTrack.heightAnchor.constraint(equalToConstant: 40),
                backTrack.heightAnchor.constraint(equalToConstant: 40),
                
                navigationTrackStackRight.leadingAnchor.constraint(equalTo:  playTrack.trailingAnchor, constant: 10),
                navigationTrackStackRight.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                navigationTrackStackRight.centerYAnchor.constraint(equalTo: playTrack.centerYAnchor),
                
                nextTrack.heightAnchor.constraint(equalToConstant: 40),
                repeatTrack.heightAnchor.constraint(equalToConstant: 40)
                
            ])
        }
        
}


////MARK: - AudioPlayer Delegate
//extension SongPlayer: AVAudioPlayerDelegate {
//    func audioPlayerDidUpdateProgress(_ player: AVAudioPlayer, currentTime: TimeInterval) {
//           let duration = player.duration
//           let progress = Float(currentTime / duration)
//
//           let currentTimeString = timeString(from: currentTime)
//           startSongTimer.text = currentTimeString
//
////           if currentTime >= duration {
////               playerDidFinishPlaying()
////           }
//       }
//
//    private func timeString(from time: TimeInterval) -> String {
//           let minutes = Int(time / 60)
//           let seconds = Int(time.truncatingRemainder(dividingBy: 60))
//           return String(format: "%d:%02d", minutes, seconds)
//       }
//
//    private func playerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
//            updateTimer?.invalidate()
//            updateTimer = nil
//        }
//}
