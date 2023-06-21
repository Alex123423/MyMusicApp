//
//  RealmAlbum.swift
//  MyMusicApp
//
//  Created by Vitali Martsinovich on 2023-06-21.
//

import Foundation
import RealmSwift

class RealmAlbumModel: Object {
    @objc dynamic var artistName: String?
    @objc dynamic var collectionName: String?
    @objc dynamic var trackName: String?
    @objc dynamic var artworkUrl60: String?
    @objc dynamic var previewUrl: String?
    @objc dynamic var localFileUrl: String?

    // Define the inverse relationship to the user who added this album to favorites
    let favoritedByUsers = LinkingObjects(fromType: UserModel.self, property: "favoriteAlbums")

    // Define the inverse relationship to the user who downloaded this album
    let downloadedByUsers = LinkingObjects(fromType: UserModel.self, property: "downloadedAlbums")
}
