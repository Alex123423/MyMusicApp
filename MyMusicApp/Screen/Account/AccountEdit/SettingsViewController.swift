//
//  SettingsViewController.swift
//  MyMusicApp
//
//  Created by Vitali Martsinovich on 2023-06-13.
//

import UIKit

class SettingsViewController: UIViewController {

    private let settingsView = SettingsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setDelegates()
    }
}

//MARK: - Buttons' delegates

extension SettingsViewController {
    
    private func setDelegates() {
    }
    
    private func setupViews() {
        view.backgroundColor = .maBackground
        view.addSubview(settingsView)
    }
    
    private func setupConstraints() {
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            settingsView.topAnchor.constraint(equalTo: view.topAnchor),
            settingsView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            settingsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}
