//
//  Album.swift
//  MyMusicApp
//
//  Created by Alexey Davidenko on 09.06.2023.
//

import Foundation

// MARK: - AlbumResult
struct AlbumResult: Decodable {
    var resultCount: Int?
    var results: [Album]
}

// MARK: - Result
struct Album: Decodable {
    var artistName: String?
    var collectionName: String?
    var trackName: String?
    var artworkUrl60: String?
}
