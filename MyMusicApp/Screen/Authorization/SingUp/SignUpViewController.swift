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
    private let authManager = AuthManager.shared
    private let realmManager = RealmManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setDelegates()
    }
    
    private func setDelegates() {
        signUpView.delegate = self
    }
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
            guard let self = self else {
                if let vc = self {
                    AlertManager.displayAlert(title: "Error", message: "\(error?.localizedDescription ?? "")", presentingViewController: vc)
                }
                return
            }
            
            let homeVC = HomeScreenViewController()
            self.present(homeVC, animated: true)
            if let currentUser = self.authManager.getCurrentEmailUser() {
                self.realmManager.saveUserToRealm(user: currentUser)
                self.realmManager.updateUsername(username: username)
            }
        }
    }
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
