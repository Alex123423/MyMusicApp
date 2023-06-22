//
//  RestorePassViewController.swift
//  Firebase_Tasks
//
//  Created by Vitali Martsinovich on 2023-06-11.
//

import UIKit
import Firebase

final class ChangePassViewController: UIViewController {

    private let restorePassView = ChangePassView()
    private let authManager = AuthManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setDelegates()
    }
    
    private func setDelegates() {
        restorePassView.delegate = self
    }
}

//MARK: - SignUp View delegate (for buttons)

extension ChangePassViewController: ChnageButtonDelegate  {
    
    func didTapChangeButton() {
        guard let newPass = restorePassView.newPassTextField.userTextField.text,
              let confirmed = restorePassView.confirmNewPassTextField.userTextField.text else {
            return
        }
        
        guard newPass == confirmed else {
            AlertManager.displayAlert(title: "Error", message: "Passwords don't match", presentingViewController: self)
            return
        }
        authManager.updatePass(with: newPass, presenterVC: self)
    }
}

extension ChangePassViewController {
    
    private func setupViews() {
        view.addSubview(restorePassView)
    }
    
    private func setupConstraints() {
        restorePassView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            restorePassView.topAnchor.constraint(equalTo: view.topAnchor),
            restorePassView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            restorePassView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            restorePassView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
        ])
    }
}

