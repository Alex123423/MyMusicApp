//
//  AuthManager.swift
//  MyMusicApp
//
//  Created by Vitali Martsinovich on 2023-06-17.
//

import Foundation
import FirebaseAuth
import GoogleSignIn

final class AuthManager {
    
    static let shared = AuthManager()
    private init() { }
    
    func getCurrentEmailUser() -> UserModel? {
        guard let currentUser = Auth.auth().currentUser else {
            return nil
        }
        let userModel = UserModel()
        userModel.idUuid = currentUser.uid
        userModel.email = currentUser.email ?? "None"
        userModel.name = currentUser.displayName
        userModel.dateBirth = nil
        userModel.gender = nil
        userModel.avatarImage = nil
        return userModel
    }
    
    func saveCurrentUserToRealm() {
        guard let currentUser = getCurrentEmailUser() else {
            return
        }
        RealmManager.shared.saveUserToRealm(user: currentUser)
    }
    
}
