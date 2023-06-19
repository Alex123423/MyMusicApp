//
//  ViewController.swift
//  Firebase_Tasks
//
//  Created by Vitali Martsinovich on 2023-06-08.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

final class SignInViewController: UIViewController {
    
    private let signInView = SignInView()
    private let accountVC = AccountMainViewController()
    private let realmManager = RealmManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupViews()
        setupConstraints()
        setDelegates()
        checkPreviousAuth()
    }
    
    func checkPreviousAuth() {
        // check Google auth first
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if error != nil || user == nil {
                Auth.auth().addStateDidChangeListener { [weak self] auth, user in
                    guard let self = self else { return }
                    if user != nil {
                        self.showTabBar()
                    }
                }
            } else {
                self.showTabBar()
            }
        }
    }
    
    func showTabBar() {
        let tabBar = TabBarViewController().customTabBar
        tabBar.modalTransitionStyle = .flipHorizontal
        tabBar.modalPresentationStyle = .fullScreen
        present(tabBar, animated: true)
    }
    
    private func setDelegates() {
        signInView.delegate = self
    }
    
    func downloadImage(from url: URL, completion: @escaping (Data?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let imageData = data else {
                print("Error downloading image: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }
            completion(imageData)
        }.resume()
    }
}

//MARK: - SignIn View delegate (for buttons)

extension SignInViewController: SignInViewDelegate {
    func signInView(_ view: SignInView, didTapSignInButton button: UIButton) {
        guard let email = signInView.emailTextField.userTextField.text,
              let password = signInView.passwordTextField.userTextField.text else {
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (user, error) in
            if error == nil {
                self?.showTabBar()
            } else {
                if let vc = self {
                    AlertManager.displayAlert(title: "Error", message: "\(error!.localizedDescription)", presentingViewController: vc)
                }
            }
        }
    }
    
    func signInView(_ view: SignInView, didTapForgotPasswordButton button: UIButton) {
        let forgotVC = ForgotPassViewController()
        self.navigationController?.pushViewController(forgotVC, animated: true)
    }
    
    func signInView(_ view: SignInView, didTapSignUpButton button: UIButton) {
        let signUpVC = SignUpViewController()
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    func signInView(_ view: SignInView, didTapGoogletButton button: UIButton) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [weak self] signInResult, error in
            guard let self = self else { return }
            guard error == nil else {
                print("Google Sign-In error: \(error!.localizedDescription)")
                return
            }
            guard let currentGoogleUser = signInResult?.user else { return }
            let googleUser = UserModel()
            googleUser.idUuid = currentGoogleUser.userID ?? "None"
            googleUser.name = currentGoogleUser.profile?.name
            googleUser.email = currentGoogleUser.profile?.email ?? "None"
            // dowloading google user image and save to realm
            if let profilePicUrl = currentGoogleUser.profile?.imageURL(withDimension: 320) {
                self.downloadImage(from: profilePicUrl) { data in
                    DispatchQueue.main.async {
                        googleUser.avatarImage = data
                        self.realmManager.saveUserToRealm(user: googleUser)
                        self.showTabBar()
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.realmManager.saveUserToRealm(user: googleUser)
                }
            }
            self.showTabBar()
        }
    }
}


extension SignInViewController {
    
    private func setupViews() {
        view.addSubview(signInView)
    }
    
    private func setupConstraints() {
        signInView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signInView.topAnchor.constraint(equalTo: view.topAnchor),
            signInView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            signInView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            signInView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
        ])
    }
}

extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        signInView.emailTextField.resignFirstResponder()
        return true
    }
}

