//
//  RealmManager.swift
//  MyMusicApp
//
//  Created by Vitali Martsinovich on 2023-06-17.
//

import RealmSwift
import Foundation

final class RealmManager {
    
    // MARK: - Properties
    
    static let shared = RealmManager()
    private let realm = try! Realm()
    
    // MARK: - Initialization
    
    private init() {
        print("Realm is located at:", realm.configuration.fileURL!)
    }
    
    func saveUserToRealm(user: UserModel) {
        let userModel = UserModel()
        userModel.idUuid = user.idUuid
        userModel.name = user.name
        userModel.email = user.email
        userModel.dateBirth = user.dateBirth
        userModel.gender = user.gender
        userModel.avatarImage = user.avatarImage

        do {
            try realm.write {
                realm.add(userModel, update: .modified) // Save or update the object
            }
            print("User data saved to Realm successfully.")
        } catch {
            print("Error saving user data to Realm: \(error)")
        }
    }
    
    func getUsersFromRealm() -> Results<UserModel> {
        let users = realm.objects(UserModel.self)
        return users
    }
}
