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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupViews()
        setupConstraints()
        setDelegates()
        userExists()
    }
    
    //log in with previous user
    func userExists() {
        Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            if user != nil {
                self?.present(ChangePassViewController(), animated: true)
            }
        }
    }
    
    private func setDelegates() {
        signInView.delegate = self
    }
}

//MARK: - SignIn View delegate (for buttons)¬

extension SignInViewController: SignInViewDelegate {
    func signInView(_ view: SignInView, didTapSignInButton button: UIButton) {
        guard let email = signInView.emailTextField.userTextField.text,
              let password = signInView.passwordTextField.userTextField.text else {
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (user, error) in
            guard let error = error else {
                self?.present(ChangePassViewController(), animated: true) // VC to present
                return
            }
            if let vc = self {
                AlertManager.displayAlert(title: "Error", message: "\(error.localizedDescription)", presentingViewController: vc)
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
        //        vc.modalPresentationStyle = .fullScreen
        //        present(vc, animated: true)
    }
    
    func signInView(_ view: SignInView, didTapGoogletButton button: UIButton) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            guard error == nil else {
                print("Google Sign-In error: \(error!.localizedDescription)")
                return
            }
            self.present(ChangePassViewController(), animated: true)
            //        startGoogleSignIn()
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

