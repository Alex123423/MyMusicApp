//
//  SignUpView.swift
//  Firebase_Tasks
//
//  Created by Vitali Martsinovich on 2023-06-10.
//

import UIKit

protocol SignUpButtonDelegate: AnyObject {
    func didTapSignUpButton()
}

final class SignUpView: UIView {
    
    weak var delegate: SignUpButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        configureElements()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Elements
    
    private let backImage = UIImageView(imageName: AuthConstant.Image.singUpBackground!)
     let emailTextField = ReusableTextField()
     let passwordTextField = ReusableTextField()
     let nameTextField = ReusableTextField()
    private let showPassButton = UIButton(target: self, action: #selector(showPassButtonTapped))
    private let signUpButton = ReusableAuthButton(title: AuthConstant.Text.singUp, target: self, action: #selector(signUpButtonTapped))
    private let signUpLabel = UILabel()
    
    // MARK: - Buttons' methods
    
    @objc private func signUpButtonTapped() {
        self.delegate?.didTapSignUpButton()
    }
    
    @objc private func showPassButtonTapped() {
        passwordTextField.userTextField.isSecureTextEntry.toggle()
        //        let buttonImage = passwordTextField.userTextField.isSecureTextEntry ? UIImage(systemName: "eye.slash") : UIImage(named: "eye")
        //        showPassButton.setImage(buttonImage, for: .normal)
    }
    
    // MARK: - Methods for setting UI
    
    private func setupViews() {
        addSubview(backImage)
        addSubview(signUpLabel)
        addSubview(nameTextField)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        passwordTextField.addSubview(showPassButton)
        addSubview(signUpButton)
    }
    
    private func configureElements() {
        signUpLabel.text = AuthConstant.Text.singUp
        signUpLabel.textColor = CommonConstant.Color.white
        signUpLabel.font = CommonConstant.FontSize.fontBold36
        signUpLabel.numberOfLines = 0
        signUpLabel.textAlignment = .center
        signUpLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameTextField.icon = AuthConstant.Symbol.name
        nameTextField.setPlaceholder(AuthConstant.Text.name, color: CommonConstant.Color.lightGray!)
        
        emailTextField.icon = AuthConstant.Symbol.email
        emailTextField.setPlaceholder(AuthConstant.Text.email, color: CommonConstant.Color.lightGray!)
        
        passwordTextField.icon = AuthConstant.Symbol.lock
        passwordTextField.setPlaceholder(AuthConstant.Text.password, color: CommonConstant.Color.lightGray!)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backImage.topAnchor.constraint(equalTo: topAnchor),
            backImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            backImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            backImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            signUpLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            signUpLabel.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            
            nameTextField.topAnchor.constraint(equalTo: signUpLabel.bottomAnchor, constant: 70),
            nameTextField.heightAnchor.constraint(equalToConstant: 22),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 40),
            emailTextField.heightAnchor.constraint(equalToConstant: 22),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 40),
            passwordTextField.heightAnchor.constraint(equalToConstant: 22),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            showPassButton.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            showPassButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            
            signUpButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            signUpButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            signUpButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 135),
            signUpButton.heightAnchor.constraint(equalToConstant: 45),
            
        ])
    }
}
