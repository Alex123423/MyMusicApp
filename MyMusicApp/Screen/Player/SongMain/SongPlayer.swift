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
       return button
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
         button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(SongConstant.Symbol.favourite, for: .normal)
        return button
     }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
         button.translatesAutoresizingMaskIntoConstraints = false
         button.setImage(SongConstant.Symbol.download, for: .normal)
        return button
     }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CommonConstant.Color.playerBackground
        layout()
    }
    
    func layout() {
        
        view.addSubview(pictureSong)
        view.addSubview(songTitle)
        view.addSubview(artistTitle)
        view.addSubview(albumTitle)
        view.addSubview(stackView)
        stackView.addArrangedSubview(shareButton)
        stackView.addArrangedSubview(addPlaylistButton)
        stackView.addArrangedSubview(favoriteButton)
        stackView.addArrangedSubview(downloadButton)
        
        NSLayoutConstraint.activate([
            
            pictureSong.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pictureSong.topAnchor.constraint(equalTo: view.topAnchor, constant: 170),
            pictureSong.heightAnchor.constraint(equalToConstant: 240),
            pictureSong.widthAnchor.constraint(equalToConstant: 240),
            
            songTitle.topAnchor.constraint(equalTo: pictureSong.bottomAnchor, constant: 20),
            songTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            artistTitle.topAnchor.constraint(equalTo: songTitle.bottomAnchor, constant: 10),
            artistTitle.centerXAnchor.constraint(equalTo: songTitle.centerXAnchor),
            
            albumTitle.topAnchor.constraint(equalTo: artistTitle.bottomAnchor, constant: 30),
            albumTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: albumTitle.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 30)
            
            
            
        ])
    }
    
}
