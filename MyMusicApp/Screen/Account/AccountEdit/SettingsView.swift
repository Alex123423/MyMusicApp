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
}

final class SettingsView: UIView {
    
    weak var delegate: SettingsViewDelegate?
    
    private let grayView = UIView()
    private let changePassButton = UIButton(type: .system)
    let avatarImageView = UIImageView()
    private let cameraButton = UIButton(type: .system)
    private let userInfoTableView = UITableView()

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


//MARK: - TableView DataSource and Delegate

extension SettingsView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfoCell", for: indexPath) as! UserInfoCell
        
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = "Username"
            cell.textField.placeholder = "Username"
        case 1:
            cell.titleLabel.text = "Email"
            cell.textField.placeholder = "Email"
        case 2:
            cell.titleLabel.text = "Gender"
            cell.textField.placeholder = "Gender"
        case 3:
            cell.titleLabel.text = "Date of birth"
            cell.textField.placeholder = "dd/mm/yy"
        default:
            break
        }
        return cell
    }
}

// MARK: - Methods for setting UI

extension SettingsView {
    
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing))
        addGestureRecognizer(tapGesture)
    }
    
    private func setDelegates() {
        
    }

    private func configureTableView() {
        userInfoTableView.dataSource = self
        userInfoTableView.delegate = self
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
        
        avatarImageView.image = UIImage(systemName: "photo")
        avatarImageView.tintColor = UIColor(named: CommonConstant.Color.lightGray)
        avatarImageView.contentMode = .scaleToFill
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
