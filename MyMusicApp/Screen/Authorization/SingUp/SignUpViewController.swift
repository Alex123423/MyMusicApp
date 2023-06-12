//
//  SignUpViewController.swift
//  Firebase_Tasks
//
//  Created by Vitali Martsinovich on 2023-06-10.
//

import UIKit
import Firebase
import FirebaseAuth

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
}

//MARK: - SignUp Button delegate (for buttons)

extension SignUpViewController: SignUpButtonDelegate {
    
    func didTapSignUpButton() {
        
        guard let email = signUpView.emailTextField.userTextField.text,
              let password = signUpView.passwordTextField.userTextField.text else {
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (user, error) in
            guard let error = error else {
                self?.present(ChangePassViewController(), animated: true) // VC to present
                return
            }
            if let vc = self {
                AlertManager.displayAlert(title: "Error", message: "\(error.localizedDescription)", presentingViewController: vc)
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
