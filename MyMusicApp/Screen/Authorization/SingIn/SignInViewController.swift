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
                        print("logged in with existing Email user")
                    }
                }
            } else {
                self.showTabBar()
                print("logged in with existing Google user")
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
        print("forgot tapped")
        let forgotVC = ForgotPassViewController()
        self.navigationController?.pushViewController(forgotVC, animated: true)
    }
    
    func signInView(_ view: SignInView, didTapSignUpButton button: UIButton) {
        print("sign up tapped")
        let signUpVC = SignUpViewController()
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    func signInView(_ view: SignInView, didTapGoogletButton button: UIButton) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [weak self] signInResult, error in
            guard error == nil else {
                print("Google Sign-In error: \(error!.localizedDescription)")
                return
            }
            guard let signInResult = signInResult else { return }
            
            //user data
            let user = signInResult.user
            let emailAddress = user.profile?.email
            let fullName = user.profile?.name
            let givenName = user.profile?.givenName
            let familyName = user.profile?.familyName
            let profilePicUrl = user.profile?.imageURL(withDimension: 320)
            print(user)
            print(emailAddress)
            print(fullName)
            print(familyName)
            print(profilePicUrl?.absoluteString)
            print(GIDSignIn.sharedInstance.currentUser)
            self?.showTabBar()
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

