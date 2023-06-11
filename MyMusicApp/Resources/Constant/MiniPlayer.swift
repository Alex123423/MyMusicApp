//
//  MiniPlayer.swift
//  MyMusicApp
//
//  Created by Alexey Davidenko on 11.06.2023.
//

import UIKit

enum MiniPlayer {
    
    enum Image {
        static let songImage = UIImage(named: "song-image")
    }
    
    enum Size {
        static let imageWidth = 43
        static let imageHeight = 43
    }
    
    enum Symbol {
        static let play = UIImage(named: "play.fill")
        static let backward = UIImage(named: "backward.end")
        static let forward = UIImage(named: "forward.end")
    }
}
