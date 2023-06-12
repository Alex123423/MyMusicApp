//
//  RestorePassView.swift
//  Firebase_Tasks
//
//  Created by Vitali Martsinovich on 2023-06-11.
//

import UIKit

protocol ChnageButtonDelegate: AnyObject {
    func didTapChangeButton()
}

final class ChangePassView: UIView {
    
    weak var delegate: ChnageButtonDelegate?
    
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
    
     let newPassTextField = ReusableTextField()
     let confirmNewPassTextField = ReusableTextField()
    private let sendButton = ReusableAuthButton(title: "CHANGE PASSWORD", target: self, action: #selector(changeButtonTapped))
    private let showPassOneButton = UIButton(target: self, action: #selector(showPassOneTapped))
    private let showPassTwoButton = UIButton(target: self, action: #selector(showPassTwoTapped))
    
    private let topLabel = UILabel()
    private let topSubLabel = UILabel()
    
    // MARK: - Buttons' methods
    
    @objc private func showPassOneTapped() {
        newPassTextField.userTextField.isSecureTextEntry.toggle()
        //        let buttonImage = passwordTextField.userTextField.isSecureTextEntry ? UIImage(systemName: "eye.slash") : UIImage(named: "eye")
        //        showPassButton.setImage(buttonImage, for: .normal)
    }
    
    @objc private func showPassTwoTapped() {
        confirmNewPassTextField.userTextField.isSecureTextEntry.toggle()
        //        let buttonImage = passwordTextField.userTextField.isSecureTextEntry ? UIImage(systemName: "eye.slash") : UIImage(named: "eye")
        //        showPassButton.setImage(buttonImage, for: .normal)
    }
    
    @objc private func changeButtonTapped() {
        self.delegate?.didTapChangeButton()
    }
    
    // MARK: - Methods for setting UI
    
    private func setupViews() {
        backgroundColor = .black
        addSubview(topLabel)
        addSubview(topSubLabel)
        addSubview(newPassTextField)
        newPassTextField.addSubview(showPassOneButton)
        addSubview(confirmNewPassTextField)
        confirmNewPassTextField.addSubview(showPassTwoButton)
        addSubview(sendButton)
    }
    
    private func configureElements() {
        topLabel.text = "Change Password"
        topLabel.textColor = .white
        topLabel.font = .boldSystemFont(ofSize: 36)
        topLabel.numberOfLines = 0
        topLabel.textAlignment = .center
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.5
        let attributedText = NSAttributedString(string: """
        Please enter your new password and confirm it in the second field.
        Your password should be at least 8 characters long
        and contain a mix of letters, numbers, and special characters.
        """, attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
            NSAttributedString.Key.foregroundColor: UIColor.lightGray,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ])
        topSubLabel.attributedText = attributedText
        topSubLabel.font = .systemFont(ofSize: 12)
        topSubLabel.numberOfLines = 0
        topSubLabel.textColor = .lightGray
        topSubLabel.textAlignment = .left
        topSubLabel.lineBreakMode = .byWordWrapping
        topSubLabel.translatesAutoresizingMaskIntoConstraints = false
        
        newPassTextField.icon = UIImage(named: "pass")
        newPassTextField.setPlaceholder("Password", color: .lightGray)
        
        confirmNewPassTextField.icon = UIImage(named: "pass")
        confirmNewPassTextField.setPlaceholder("Confirm Password", color: .lightGray)
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            topLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            topLabel.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            
            topSubLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 28),
            topSubLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            topSubLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            newPassTextField.topAnchor.constraint(equalTo: topSubLabel.bottomAnchor, constant: 90),
            newPassTextField.heightAnchor.constraint(equalToConstant: 22),
            newPassTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            newPassTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            showPassOneButton.centerYAnchor.constraint(equalTo: newPassTextField.centerYAnchor),
            showPassOneButton.trailingAnchor.constraint(equalTo: newPassTextField.trailingAnchor),
            
            confirmNewPassTextField.topAnchor.constraint(equalTo: newPassTextField.bottomAnchor, constant: 40),
            confirmNewPassTextField.heightAnchor.constraint(equalToConstant: 22),
            confirmNewPassTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            confirmNewPassTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            showPassTwoButton.centerYAnchor.constraint(equalTo: confirmNewPassTextField.centerYAnchor),
            showPassTwoButton.trailingAnchor.constraint(equalTo: confirmNewPassTextField.trailingAnchor),
            
            sendButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            sendButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            sendButton.topAnchor.constraint(equalTo: confirmNewPassTextField.bottomAnchor, constant: 65),
            sendButton.heightAnchor.constraint(equalToConstant: 45),
            
        ])
    }
    
    
}
