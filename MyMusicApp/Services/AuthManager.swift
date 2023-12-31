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
        return userModel
    }

    func getCurrentGoogleUser() -> UserModel? {
        // Retrieve the currently authenticated Google user
        if let currentUser = GIDSignIn.sharedInstance.currentUser,
           let fullName = currentUser.profile?.name,
           let email = currentUser.profile?.email {
            
            let userModel = UserModel()
            userModel.idUuid = currentUser.userID ?? "None"
            userModel.email = email
            userModel.name = fullName
            return userModel
        }
        
        return nil
    }
    
    func updateEmail(with email: String, presenterVC: UIViewController) {
        Auth.auth().currentUser?.updateEmail(to: email) { error in
            if let error = error {
                let errorMessage = "Failed to update email: \(error.localizedDescription)"
                AlertManager.displayAlert(title: "Error", message: errorMessage, presentingViewController: presenterVC)
            } else {
                let successMessage = "email updated successfully"
                RealmManager.shared.updateEmail(email: email)
                AlertManager.displayAlert(title: "Success", message: successMessage, presentingViewController: presenterVC)
            }
        }
    }
    
    func updatePass(with pass: String, presenterVC: UIViewController) {
        Auth.auth().currentUser?.updatePassword(to: pass) { error in
            if let error = error {
                let errorMessage = "Failed to update password: \(error.localizedDescription)"
                AlertManager.displayAlert(title: "Error", message: errorMessage, presentingViewController: presenterVC)
            } else {
                let successMessage = "Password updated successfully"
                AlertManager.displayAlert(title: "Success", message: successMessage, presentingViewController: presenterVC)
            }
        }
    }
}
