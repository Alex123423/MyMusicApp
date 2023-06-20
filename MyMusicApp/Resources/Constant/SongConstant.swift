//
//  Song.swift
//  MyMusicApp
//
//  Created by Alexey Davidenko on 11.06.2023.
//

import UIKit


enum SongConstant {
    
    enum Image {
        static let songImage = UIImage(named: "songImage")
    }
    
    enum Text {
        //Title
        static let playlist = "Playlist"
        static let song = "Song"
        static let createPlaylist = "CREATE PLAYLIST"
        
        //Label
        static let addSong = "Add this song to My Playlist"
        static let dowloadSong = "Downloading 128Kbps for this song"
        static let enterPlaylistName = "Enter your playlist name"
        
        //Button
        static let factToReadButton = "It is a long established fact that a reader"
        static let AddPlaylistButton = "Add New Playlist"
        static let okButton = "OK"
        static let showMore = "Show More"
    }
    
    enum Symbol {
        static let share = UIImage(named: "share-icon")
        static let add = UIImage(systemName: "text.badge.plus")
        static let favourite = UIImage(systemName: "heart")
        static let favouriteTapped = UIImage(systemName: "heart.fill")
        static let download = UIImage(systemName: "arrow.down.to.line")
        static let playButton = UIImage(systemName: "play")
        static let pauseButton = UIImage(systemName: "pause.fill")
        
        static let shuffle = UIImage(systemName: "shuffle")
        static let shuffleicon = UIImage(named: "shuffle-icon")
        static let backword = UIImage(systemName: "backward.end")
        static let forward = UIImage(systemName: "forward.end")
        static let repeatOne = UIImage(systemName: "arrow.triangle.2.circlepath")
        
        static let shuffleButton = UIImage(named: "shuffle-icon")
        static let repeatButton = UIImage(named: "repeatButton")
        static let backTrackButton = UIImage(named: "backButton")
        static let nextTrackButton = UIImage(named: "nextButton")
    }
}
