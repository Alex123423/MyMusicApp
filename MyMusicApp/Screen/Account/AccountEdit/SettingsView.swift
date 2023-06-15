//
//  SettingsView.swift
//  MyMusicApp
//
//  Created by Vitali Martsinovich on 2023-06-14.
//

import UIKit

final class SettingsView: UIView {
    
    private let grayView = UIView()
    private let changePassButton = UIButton(type: .system)

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        configureElements()
        setupConstraints()
        setDelegates()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Buttons' methods
    
    @objc func changePassTapped() {
        
    }
    
}


// MARK: - Methods for setting UI

extension SettingsView {
    
    private func setDelegates() {
        
    }
    
    private func configureElements() {
        changePassButton.setTitle(AccountConstant.Text.changePasswordButton, for: .normal)
        changePassButton.setTitleColor(.maCustomYellow, for: .normal)
        changePassButton.titleLabel?.font = CommonConstant.FontSize.font14
        changePassButton.addTarget(self, action: #selector(changePassTapped), for: .touchUpInside)
        changePassButton.translatesAutoresizingMaskIntoConstraints = false
        
        grayView.backgroundColor = .maDarkGray
        grayView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupViews() {
        addSubview(changePassButton)
        addSubview(grayView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            changePassButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -75),
            changePassButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            grayView.topAnchor.constraint(equalTo: topAnchor, constant: 180),
            grayView.bottomAnchor.constraint(equalTo: changePassButton.topAnchor, constant: -45),
            grayView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            grayView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            

        ])
    }
}
