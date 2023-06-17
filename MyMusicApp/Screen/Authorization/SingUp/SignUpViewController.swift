//
//  SignUpViewController.swift
//  Firebase_Tasks
//
//  Created by Vitali Martsinovich on 2023-06-10.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import RealmSwift

final class SignUpViewController: UIViewController {
    
    private let signUpView = SignUpView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setDelegates()
    }
    
    private func setDelegates() {
        signUpView.delegate = self
    }
    
    //saving user to realm
//    func getCurrentEmailUser() -> UserModel? {
//        guard let currentUser = Auth.auth().currentUser else {
//            return nil
//        }
//        let userModel = UserModel()
//        userModel.idUuid = currentUser.uid
//        userModel.email = currentUser.email ?? "None"
//        userModel.name = currentUser.displayName
//        userModel.dateBirth = nil
//        userModel.gender = nil
//        userModel.avatarImage = nil
//        return userModel
//    }
//
//    func saveCurrentUserToRealm() {
//        guard let currentUser = getCurrentEmailUser() else {
//            return
//        }
//        RealmManager.shared.saveUserToRealm(user: currentUser)
//    }
}

//MARK: - SignUp Button delegate (for buttons)

extension SignUpViewController: SignUpButtonDelegate {
    
    func didTapSignUpButton() {
        
        guard let email = signUpView.emailTextField.userTextField.text,
              let password = signUpView.passwordTextField.userTextField.text,
              let username = signUpView.nameTextField.userTextField.text else {
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (authResult, error) in
            guard let user = authResult?.user else {
                if let vc = self {
                    AlertManager.displayAlert(title: "Error", message: "\(String(describing: error?.localizedDescription))", presentingViewController: vc)
                }
                return
            }
            // Update the user's profile with the username
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = username
            changeRequest.commitChanges { (error) in
                if let error = error {
                    print("Error updating user profile with username \(error)")
                    return
                }
                // User created with email, password, and username successfully
                let homeVC = HomeScreenViewController()
                self?.present(homeVC, animated: true)
                if let currentUser = AuthManager.shared.getCurrentEmailUser() {
                    RealmManager.shared.saveUserToRealm(user: currentUser)
                }
            }
        }
    }
    
    //        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (user, error) in
    //            guard let error = error else {
    //                self?.present(HomeScreenViewController(), animated: true) // VC to present
    //                return
    //            }
    //
    //        }
    //    }
}

extension SignUpViewController {
    
    private func setupViews() {
        view.addSubview(signUpView)
    }
    
    private func setupConstraints() {
        signUpView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signUpView.topAnchor.constraint(equalTo: view.topAnchor),
            signUpView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            signUpView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            signUpView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
        ])
    }
}
