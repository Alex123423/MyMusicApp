//
//  ForgotPassView.swift
//  Firebase_Tasks
//
//  Created by Vitali Martsinovich on 2023-06-10.
//

import UIKit

protocol SendButtonDelegate: AnyObject {
    func didTapSendButton()
}

final class ForgotPassView: UIView {
    
    weak var delegate: SendButtonDelegate?
    
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
    
     let emailTextField = ReusableTextField()
    private let sendButton = ReusableAuthButton(title: AuthConstant.Text.sentButton, target: self, action: #selector(sendButtonTapped))
    private let topLabel = UILabel()
    private let topSubLabel = UILabel()
    
    // MARK: - Buttons' methods
    
    @objc private func sendButtonTapped() {
        self.delegate?.didTapSendButton()
    }
    
    // MARK: - Methods for setting UI
    
    private func setupViews() {
        backgroundColor = .black
        addSubview(topLabel)
        addSubview(topSubLabel)
        addSubview(emailTextField)
        addSubview(sendButton)
    }
    
    private func configureElements() {
        topLabel.text = AuthConstant.Text.forgotPasswordTitle
        topLabel.textColor = .white
        topLabel.font = CommonConstant.FontSize.fontBold36
        topLabel.numberOfLines = 0
        topLabel.textAlignment = .center
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.5
        let attributedText = NSAttributedString(string: AuthConstant.Text.resetPasswordText, attributes: [
            NSAttributedString.Key.font: CommonConstant.FontSize.font12,
            NSAttributedString.Key.foregroundColor: UIColor(named: CommonConstant.Color.lightGray) as Any,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ])
        topSubLabel.attributedText = attributedText
        topSubLabel.numberOfLines = 0
        topSubLabel.textAlignment = .left
        topSubLabel.lineBreakMode = .byWordWrapping
        topSubLabel.translatesAutoresizingMaskIntoConstraints = false
        
        emailTextField.icon = AuthConstant.Symbol.email
        emailTextField.setPlaceholder(AuthConstant.Text.email, color: .maLightGray)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            topLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            topLabel.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            
            topSubLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 28),
            topSubLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            
            emailTextField.topAnchor.constraint(equalTo: topSubLabel.bottomAnchor, constant: 90),
            emailTextField.heightAnchor.constraint(equalToConstant: 22),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            sendButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            sendButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            sendButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 65),
            sendButton.heightAnchor.constraint(equalToConstant: 45),
            
        ])
    }
}

