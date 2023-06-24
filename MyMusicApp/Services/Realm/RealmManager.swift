//
//  RealmManager.swift
//  MyMusicApp
//
//  Created by Vitali Martsinovich on 2023-06-17.
//

import RealmSwift
import Foundation
import FirebaseAuth

final class RealmManager {
    
    // MARK: - Properties
    
    static let shared = RealmManager()
    private let authManager = AuthManager.shared
    private let realm: Realm
    
    // MARK: - Initialization
    
    private init() {
        var config = Realm.Configuration()
        config.schemaVersion = 2
        config.migrationBlock = { migration, oldSchemaVersion in
            if oldSchemaVersion < 2 {
                migration.enumerateObjects(ofType: UserModel.className()) { oldObject, newObject in
                    newObject?["favoriteAlbums"] = List<RealmAlbumModel>()
                    newObject?["downloadedAlbums"] = List<RealmAlbumModel>()
                }
            }
        }
        do {
            realm = try Realm(configuration: config)
        } catch {
            fatalError("Error initializing Realm: \(error)")
        }
        
        print("Realm is located at:", realm.configuration.fileURL!)
    }
    
    //MARK: - Realm user management
    
    var currentRealmUser: UserModel? {
        fetchCurrentUserFromRealm()
    }
    
    func saveUserToRealm(user: UserModel) {
        let existingUser = getUsersFromRealm(currentUser: user).first
        
        guard existingUser == nil else {
            print("User with ID \(user.idUuid) already exists in Realm. Skipping save.")
            return
        }
        
        do {
            try realm.write {
                realm.add(user, update: .modified)
            }
            print("User data saved to Realm successfully.")
        } catch {
            print("Error saving user data to Realm: \(error)")
        }
    }
    
    func updateGender(gender: String) {
        guard let currentUser = currentRealmUser else {
            print("Current user not found.")
            return
        }
        realm.beginWrite()
        currentUser.gender = gender
        do {
            try realm.commitWrite()
            print("Gender updated successfully.")
        } catch {
            print("Error updating gender: \(error)")
        }
    }
    
    func updateDateOfBirth(dateOfBirth: Date?) {
        guard let currentUser = currentRealmUser else {
            print("Current user not found.")
            return
        }
        realm.beginWrite()
        currentUser.dateBirth = dateOfBirth
        do {
            try realm.commitWrite()
            print("Date of Birth updated successfully.")
        } catch {
            print("Error updating date of birth: \(error)")
        }
    }
    
    func updateUsername(username: String?) {
        guard let currentUser = currentRealmUser else {
            print("Current user not found.")
            return
        }
        realm.beginWrite()
        currentUser.name = username
        do {
            try realm.commitWrite()
            print("Username updated successfully.")
        } catch {
            print("Error updating Username: \(error)")
        }
    }
    
    func updateEmail(email: String?) {
        guard let currentUser = currentRealmUser else {
            print("Current user not found.")
            return
        }
        realm.beginWrite()
        currentUser.email = email!
        do {
            try realm.commitWrite()
            print("Email updated successfully.")
        } catch {
            print("Error updating Email: \(error)")
        }
    }
    
    func updateAvatarImageData(_ imageData: Data) {
        guard let currentUser = currentRealmUser else {
            return
        }
        do {
            try realm.write {
                
                currentUser.avatarImage = imageData
                print("Avatar image saved successfully.")
            }
        } catch {
            print("Failed to update avatar image data: \(error)")
        }
    }
    
    //MARK: - Album management
    
    func saveRealmAlbum(albumToSave: RealmAlbumModel) {
        guard let currentUser = self.currentRealmUser else {
            print("Current user not found.")
            return
        }
        do {
            try self.realm.write {
                currentUser.downloadedAlbums.append(albumToSave)
            }
            print("Realm album saved successfully.")
        } catch {
            print("Error saving realm album: \(error)")
        }
    }
    
    func fetchDownloadedAlbums() -> [RealmAlbumModel]? {
        guard let currentUser = currentRealmUser else {
            print("Current user not found.")
            return nil
        }
        return Array(currentUser.downloadedAlbums)
    }
    
    func createRealmAlbum(album: Album? = nil) -> RealmAlbumModel {
        let realmAlbum = RealmAlbumModel()
        realmAlbum.artistName = album?.artistName ?? ""
        realmAlbum.trackName = album?.trackName ?? ""
        realmAlbum.artworkUrl60 = album?.artworkUrl60 ?? ""
        realmAlbum.previewUrl = album?.previewUrl ?? ""
        return realmAlbum
    }
    
    func saveFavouriteToRealm(albumToSave: Album) throws {
        guard let currentUser = self.currentRealmUser else {
            throw NSError(domain: "MyMusicApp", code: 1, userInfo: [NSLocalizedDescriptionKey: "Current user not found."])
        }
        let realmAlbum = createRealmAlbum(album: albumToSave)
        
        do {
            try self.realm.write {
                currentUser.favoriteAlbums.append(realmAlbum)
            }
            print("Realm album saved successfully.")
        } catch {
            throw error
        }
    }
    
    func deleteFavoriteFromRealm(trackToDelete: String) throws {
        guard let album = self.currentRealmUser?.favoriteAlbums.first(where: { $0.trackName == trackToDelete }) else {
            throw NSError(domain: "RealmError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Album not found in Realm"])
        }
        do {
            try realm.write {
                realm.delete(album)
            }
        } catch let error {
            throw error
        }
    }
    
    func fetchFavouriteAlbums() -> [RealmAlbumModel]? {
        guard let currentUser = currentRealmUser else {
            print("Current user not found.")
            return nil
        }
        return Array(currentUser.favoriteAlbums)
    }
    
    func isAlbumFavorite(trackName: String) -> Bool {
        guard let currentUser = self.currentRealmUser else {
            return false
        }
        
        return currentUser.favoriteAlbums.contains { $0.trackName == trackName }
    }
    
    //MARK: - Helpers
    private func getUsersFromRealm(currentUser: UserModel) -> Results<UserModel> {
        let users = realm.objects(UserModel.self).filter("idUuid == %@", currentUser.idUuid)
        return users
    }
    
    private func fetchCurrentUserFromRealm() -> UserModel? {
        if let currentUser = authManager.getCurrentEmailUser() {
            let users = getUsersFromRealm(currentUser: currentUser)
            print("email user is current")
            return users.first
        } else if let currentUser = authManager.getCurrentGoogleUser() {
            let users = getUsersFromRealm(currentUser: currentUser)
            print("google user is current")
            return users.first
        } else {
            return nil
        }
    }
    
    func isAlbumSaved(_ album: Album) -> Bool {
        guard let currentUser = currentRealmUser else {
            print("Current user not found.")
            return false
        }
        return currentUser.downloadedAlbums.contains { realmAlbum in
            realmAlbum.trackName == album.trackName && realmAlbum.artistName == album.artistName
        }
    }
    
    func getLocalFileURLString(for album: Album) -> String? {
        guard let currentUser = currentRealmUser else {
            print("Current user not found.")
            return nil
        }
        if let realmAlbum = currentUser.downloadedAlbums.first(where: { $0.trackName == album.trackName && $0.artistName == album.artistName }),
           let localFileURLString = realmAlbum.localFileUrl {
            return localFileURLString
        }
        return nil
    }
}
