//
//  SignInView.swift
//  Firebase_Tasks
//
//  Created by Vitali Martsinovich on 2023-06-08.
//

import UIKit

protocol SignInViewDelegate: AnyObject {
    func signInView(_ view: SignInView, didTapSignInButton button: UIButton)
    func signInView(_ view: SignInView, didTapForgotPasswordButton button: UIButton)
    func signInView(_ view: SignInView, didTapSignUpButton button: UIButton)
    func signInView(_ view: SignInView, didTapGoogletButton button: UIButton)
}

final class SignInView: UIView {
    
    weak var delegate: SignInViewDelegate?
    
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
    
    private let backImage = UIImageView(imageName: AuthConstant.Image.singInBackground!)
     let emailTextField = ReusableTextField()
     let passwordTextField = ReusableTextField()
    private let connectWithLine = ReusableGrayLine()
    private let connectWithLine2 = ReusableGrayLine()
    private let showPassButton = UIButton(target: self, action: #selector(showPassButtonTapped))
    private let signInButton = ReusableAuthButton(title: AuthConstant.Text.singIn, target: self, action: #selector(signInButtonTapped))
    private let signInLabel = UILabel()
    private let forgotPassButton = UIButton(type: .system)
    private let connectWithLabel = UILabel()
    private let googleButton = UIButton(type: .system)
    private let bottomStack = UIStackView()
    private let dontHaveLabel = UILabel()
    private let signUpButton = UIButton(type: .system)
    
    // MARK: - Buttons' methods
    
    @objc private func signUpButtonTapped() {
        delegate?.signInView(self, didTapSignUpButton: signUpButton)
    }
    
    @objc private func googleButtonTapped() {
        delegate?.signInView(self, didTapGoogletButton: googleButton)
    }
    
    @objc private func signInButtonTapped() {
        delegate?.signInView(self, didTapSignInButton: signInButton)
    }
    
    @objc private func forgotPasswordTapped() {
        delegate?.signInView(self, didTapForgotPasswordButton: forgotPassButton)
    }
    
    @objc private func showPassButtonTapped() {
        passwordTextField.userTextField.isSecureTextEntry.toggle()
    }
    
    // MARK: - Methods for setting UI
    
    private func setupViews() {
        addSubview(backImage)
        addSubview(signInLabel)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(forgotPassButton)
        passwordTextField.addSubview(showPassButton)
        addSubview(signInButton)
        addSubview(connectWithLabel)
        addSubview(connectWithLine)
        addSubview(connectWithLine2)
        addSubview(googleButton)
        bottomStack.addArrangedSubview(dontHaveLabel)
        bottomStack.addArrangedSubview(signUpButton)
        addSubview(bottomStack)
    }
    
    private func configureElements() {
        signInLabel.text = AuthConstant.Text.singIn
        signInLabel.textColor = .white
        signInLabel.font = CommonConstant.FontSize.fontBold36
        signInLabel.numberOfLines = 0
        signInLabel.textAlignment = .center
        signInLabel.translatesAutoresizingMaskIntoConstraints = false
        
        forgotPassButton.setTitle(AuthConstant.Text.forgotPasswordTitle, for: .normal)
        forgotPassButton.setTitleColor(.maLightGray, for: .normal)
        forgotPassButton.titleLabel?.font = CommonConstant.FontSize.font14
        forgotPassButton.addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
        forgotPassButton.translatesAutoresizingMaskIntoConstraints = false
        
        connectWithLabel.text = AuthConstant.Text.connectWith
        connectWithLabel.font = CommonConstant.FontSize.font12
        connectWithLabel.textColor = .maLightGray
        connectWithLabel.textAlignment = .center
        connectWithLabel.translatesAutoresizingMaskIntoConstraints = false
        
        googleButton.setBackgroundImage(AuthConstant.Symbol.google, for: .normal)
        googleButton.addTarget(self, action: #selector(googleButtonTapped), for: .touchUpInside)
        googleButton.translatesAutoresizingMaskIntoConstraints = false
        
        dontHaveLabel.text = AuthConstant.Text.haveAccount
        dontHaveLabel.textAlignment = .left
        dontHaveLabel.textColor = .white
        dontHaveLabel.font = CommonConstant.FontSize.font14
        dontHaveLabel.translatesAutoresizingMaskIntoConstraints = false
        
        signUpButton.setTitle(AuthConstant.Text.singUpHaveAccountButton, for: .normal)
        signUpButton.setTitleColor(.maCustomYellow, for: .normal)
        signUpButton.titleLabel?.font = CommonConstant.FontSize.font14
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        
        bottomStack.axis = .horizontal
        bottomStack.distribution = .fillProportionally
        bottomStack.spacing = 6
        bottomStack.translatesAutoresizingMaskIntoConstraints = false
        
        emailTextField.icon = AuthConstant.Symbol.email
        emailTextField.setPlaceholder(AuthConstant.Text.email, color: .maLightGray)
        emailTextField.userTextField.returnKeyType = .done
        emailTextField.userTextField.autocapitalizationType = .none
        
        passwordTextField.icon = AuthConstant.Symbol.lock
        passwordTextField.setPlaceholder(AuthConstant.Text.password, color: .maLightGray)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backImage.topAnchor.constraint(equalTo: topAnchor),
            backImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            backImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            backImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            signInLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            signInLabel.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            
            emailTextField.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 70),
            emailTextField.heightAnchor.constraint(equalToConstant: 22),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 40),
            passwordTextField.heightAnchor.constraint(equalToConstant: 22),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            forgotPassButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            forgotPassButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 35),
            
            showPassButton.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            showPassButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            
            signInButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            signInButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 135),
            signInButton.heightAnchor.constraint(equalToConstant: 45),
            
            connectWithLabel.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 135),
            connectWithLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            connectWithLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            connectWithLine.trailingAnchor.constraint(equalTo: connectWithLabel.leadingAnchor, constant: -15),
            connectWithLine.centerYAnchor.constraint(equalTo: connectWithLabel.centerYAnchor),
            
            connectWithLine2.leadingAnchor.constraint(equalTo: connectWithLabel.trailingAnchor, constant: 15),
            connectWithLine2.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            connectWithLine2.centerYAnchor.constraint(equalTo: connectWithLabel.centerYAnchor),
            
            googleButton.heightAnchor.constraint(equalToConstant: 40),
            googleButton.widthAnchor.constraint(equalToConstant: 40),
            googleButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            googleButton.topAnchor.constraint(equalTo: connectWithLabel.bottomAnchor, constant: 20),
            
            bottomStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 88),
            bottomStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -88),
            bottomStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -23)
        ])
    }
}
