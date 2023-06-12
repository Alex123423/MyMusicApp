//
//  ForgotPassViewController.swift
//  Firebase_Tasks
//
//  Created by Vitali Martsinovich on 2023-06-10.
//

import UIKit
import Firebase

final class ForgotPassViewController: UIViewController {

    private let forgotPassView = ForgotPassView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setDelegates()
    }
    
    private func setDelegates() {
        forgotPassView.delegate = self
    }
}

//MARK: - Forgot button delegate (for buttons)

extension ForgotPassViewController: SendButtonDelegate {
    func didTapSendButton() {
        guard let email = forgotPassView.emailTextField.userTextField.text, !email.isEmpty else {
            let errorMessage = "Please enter your email"
            AlertManager.displayAlert(title: "Error", message: errorMessage, presentingViewController: self)
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: email) { [weak self] error in
            if let error = error {
                let errorMessage = error.localizedDescription
                if let vc = self {
                    AlertManager.displayAlert(title: "Error", message: errorMessage, presentingViewController: vc)
                }
            } else {
                if let vc = self {
                    let successMessage = "A link for resetting your password has been sent. Please check your email!"
                    AlertManager.displayAlert(title: "Success", message: successMessage, presentingViewController: vc)
                }
            }
        }
    }
}

extension ForgotPassViewController {
    
    private func setupViews() {
        view.addSubview(forgotPassView)
    }
    
    private func setupConstraints() {
        forgotPassView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            forgotPassView.topAnchor.constraint(equalTo: view.topAnchor),
            forgotPassView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            forgotPassView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            forgotPassView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
        ])
    }
}
