//
//  ReusableTextField.swift
//  Firebase_Tasks
//
//  Created by Vitali Martsinovich on 2023-06-08.
//

import UIKit

final class ReusableTextField: UIView {
    
    private let bottomLineLayer = ReusableGrayLine()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var icon: UIImage? {
        didSet {
            iconImageView.image = icon
            iconImageView.tintColor = .maLightGray
        }
    }
    
    var placeholderText: String? {
        didSet {
            userTextField.placeholder = placeholderText
        }
    }
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = icon
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var userTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.font = CommonConstant.FontSize.font14
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    func setPlaceholder(_ text: String, color: UIColor) {
        userTextField.attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [NSAttributedString.Key.foregroundColor: color]
        )
    }
    
    private func setupViews() {
        userTextField.delegate = self
        addSubview(iconImageView)
        addSubview(userTextField)
        addSubview(bottomLineLayer)
    }

    private func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: topAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 18),
            iconImageView.widthAnchor.constraint(equalToConstant: 18),
            
            userTextField.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            userTextField.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 20),
            userTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            bottomLineLayer.topAnchor.constraint(equalTo: userTextField.bottomAnchor,constant: 10),
            bottomLineLayer.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomLineLayer.trailingAnchor.constraint(equalTo: trailingAnchor)
            
        ])
    }
}

extension ReusableTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
