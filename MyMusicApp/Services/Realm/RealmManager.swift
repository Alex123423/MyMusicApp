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
    
    func saveRealmAlbum(realmAlbum: RealmAlbumModel) {
        guard let currentUser = self.currentRealmUser else {
            print("Current user not found.")
            return
        }
        do {
            try self.realm.write {
                currentUser.downloadedAlbums.append(realmAlbum)
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
}