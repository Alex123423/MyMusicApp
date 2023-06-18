//
//  SettingsView.swift
//  MyMusicApp
//
//  Created by Vitali Martsinovich on 2023-06-14.
//

import UIKit

protocol SettingsViewDelegate: AnyObject {
    func settingsView(_ view: SettingsView, didTapchangePassButton button: UIButton)
    func settingsView(_ view: SettingsView, didTapcameraButton button: UIButton)
    func settingsView(_ view: SettingsView, didSelectGenderRow row: Int)
    
}

final class SettingsView: UIView {
    
    weak var delegate: SettingsViewDelegate?
    
    private let grayView = UIView()
    private let changePassButton = UIButton(type: .system)
    let avatarImageView = UIImageView()
    private let cameraButton = UIButton(type: .system)
    let userInfoTableView = UITableView()
    var pickerView = UIPickerView()
    private let userCell = UserInfoCell()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        configureElements()
        setupConstraints()
        setDelegates()
        configureTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Buttons' methods
    
    @objc func changePassTapped() {
        delegate?.settingsView(self, didTapchangePassButton: changePassButton)
    }
    
    @objc func cameraTapped() {
        delegate?.settingsView(self, didTapcameraButton: cameraButton)
        
    }
}

extension SettingsView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row == 0 {
            return "Male"
        } else {
            return "Female"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.settingsView(self, didSelectGenderRow: row)
    }
}

// MARK: - Methods for setting UI

extension SettingsView {
    
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing))
        addGestureRecognizer(tapGesture)
    }
    
    private func setDelegates() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    private func configureTableView() {
        userInfoTableView.register(UserInfoCell.self, forCellReuseIdentifier: "UserInfoCell")
        userInfoTableView.backgroundColor = .maDarkGray
        userInfoTableView.separatorStyle = .singleLine
        userInfoTableView.separatorColor = .maLightGray
        userInfoTableView.rowHeight = 44
        userInfoTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureElements() {
        changePassButton.setTitle(AccountConstant.Text.changePasswordButton, for: .normal)
        changePassButton.setTitleColor(.maCustomYellow, for: .normal)
        changePassButton.titleLabel?.font = CommonConstant.FontSize.font14
        changePassButton.addTarget(self, action: #selector(changePassTapped), for: .touchUpInside)
        changePassButton.translatesAutoresizingMaskIntoConstraints = false
        
        grayView.backgroundColor = .maDarkGray
        grayView.translatesAutoresizingMaskIntoConstraints = false
        
        configureTableView()
        
        avatarImageView.image = UIImage(systemName: "person")
        avatarImageView.tintColor = UIColor(named: CommonConstant.Color.lightGray)
        avatarImageView.backgroundColor = .black
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.cornerRadius = 71
        avatarImageView.layer.borderWidth = 2
        avatarImageView.layer.borderColor = UIColor(named: CommonConstant.Color.lightGray)?.cgColor
        avatarImageView.clipsToBounds = true
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        
        var configuration = UIButton.Configuration.filled()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        configuration.image = AccountConstant.Symbol.cameraImage
        configuration.baseForegroundColor = .black
        configuration.baseBackgroundColor = .maCustomYellow
        cameraButton.configuration = configuration
        cameraButton.addTarget(self, action: #selector(cameraTapped), for: .touchUpInside)
        cameraButton.layer.cornerRadius = 20
        cameraButton.clipsToBounds = true
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func setupViews() {
        addSubview(changePassButton)
        addSubview(grayView)
        grayView.addSubview(userInfoTableView)
        addSubview(avatarImageView)
        addSubview(cameraButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            changePassButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -75),
            changePassButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            grayView.topAnchor.constraint(equalTo: topAnchor, constant: 180),
            grayView.bottomAnchor.constraint(equalTo: changePassButton.topAnchor, constant: -45),
            grayView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            grayView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            userInfoTableView.leadingAnchor.constraint(equalTo: grayView.leadingAnchor, constant: 16),
            userInfoTableView.trailingAnchor.constraint(equalTo: grayView.trailingAnchor, constant: -16),
            userInfoTableView.topAnchor.constraint(equalTo: grayView.topAnchor, constant: 150),
            userInfoTableView.bottomAnchor.constraint(equalTo: grayView.bottomAnchor, constant: -100),
            
            avatarImageView.heightAnchor.constraint(equalToConstant: 142),
            avatarImageView.widthAnchor.constraint(equalToConstant: 142),
            avatarImageView.centerYAnchor.constraint(equalTo: grayView.topAnchor),
            avatarImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            cameraButton.heightAnchor.constraint(equalToConstant: 40),
            cameraButton.widthAnchor.constraint(equalToConstant: 40),
            cameraButton.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            cameraButton.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor),
            
        ])
    }
}
