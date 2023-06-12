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
        image.layer.cornerRadius = 130
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CommonConstant.Color.playerBackground
        layout()
    }
    
    func layout() {
        
        view.addSubview(pictureSong)
        view.addSubview(songTitle)
        view.addSubview(artistTitle)
        
        NSLayoutConstraint.activate([
            
            pictureSong.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pictureSong.topAnchor.constraint(equalTo: view.topAnchor, constant: 170),
            pictureSong.heightAnchor.constraint(equalToConstant: 260),
            pictureSong.widthAnchor.constraint(equalToConstant: 260),
            
            songTitle.topAnchor.constraint(equalTo: pictureSong.bottomAnchor, constant: 20),
            songTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            artistTitle.topAnchor.constraint(equalTo: songTitle.bottomAnchor, constant: 10),
            artistTitle.centerXAnchor.constraint(equalTo: songTitle.centerXAnchor),
            
            
            
            
            
            
        
        ])
    }
    
}
