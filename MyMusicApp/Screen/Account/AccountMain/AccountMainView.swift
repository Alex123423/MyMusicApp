//
//  AccountMainView.swift
//  MyMusicApp
//
//  Created by Vitali Martsinovich on 2023-06-13.
//

import UIKit

protocol AccountMainViewDelegate: AnyObject {
    func accountView(_ view: AccountMainView, didTapSignOutButton button: UIButton)
    func accountView(_ view: AccountMainView, didTapSettingsButton button: UIButton)
    func accountView(_ view: AccountMainView, didTapToggle sender: UISwitch)
    func accountView(_ view: AccountMainView, didSelectRowAt indexPath: IndexPath)
}

final class AccountMainView: UIView {
    
    weak var delegate: AccountMainViewDelegate?
    
    private let accountLabel = UILabel()
    private let settingsButton = UIButton(type: .system)
    private let accountImage = UIImageView(imageName: AccountConstant.Image.accountImage!)
    
    private let tableView = UITableView()
    private let cellIdentifier = "SettingsCell"
    
    private let switchControl = UISwitch()
    private let signOutButton = ReusableAuthButton(title: AccountConstant.Text.singOutButton,
                                                   target: self,
                                                   action: #selector(signOutTapped))

    
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
    
    @objc func settingsButtonTapped() {
        delegate?.accountView(self, didTapSettingsButton: settingsButton)
    }
    
    @objc func signOutTapped() {
        delegate?.accountView(self, didTapSignOutButton: signOutButton)
    }
    
    @objc func switchToggled(_ sender: UISwitch) {
        delegate?.accountView(self, didTapToggle: switchControl)
    }
}


// MARK: - Methods for setting UI

extension AccountMainView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SettingsCell
    
            switch indexPath.row {
            case 0:
                cell.iconImageView.image = AccountConstant.Symbol.playlist
                cell.titleLabel.text = "My Playlist"
                cell.accessoryType = .disclosureIndicator
            case 1:
                cell.iconImageView.image = AccountConstant.Symbol.notification
                cell.titleLabel.text = "Notification"
                cell.accessoryView = switchControl
            case 2:
                cell.iconImageView.image = AccountConstant.Symbol.download
                cell.titleLabel.text = "Download"
                cell.accessoryType = .disclosureIndicator
            default:
                break
            }
            return cell
        }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.accountView(self, didSelectRowAt: indexPath)

    }
}

extension AccountMainView {
    
    private func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupTableView() {
        tableView.register(SettingsCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .white
        tableView.backgroundColor = .maBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureElements() {
        switchControl.onTintColor = .maCustomYellow
        switchControl.addTarget(self, action: #selector(switchToggled(_:)), for: .valueChanged)
        
        accountLabel.text = AccountConstant.Text.account
        accountLabel.textColor = .white
        accountLabel.font = CommonConstant.FontSize.fontBold48
        accountLabel.numberOfLines = 0
        accountLabel.textAlignment = .center
        accountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        settingsButton.setBackgroundImage(AccountConstant.Symbol.settings, for: .normal)
        settingsButton.tintColor = .white
        settingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        
        setupTableView()
        
        signOutButton.backgroundColor = .maBackground
        signOutButton.setTitleColor(.maCustomYellow, for: .normal)
        signOutButton.layer.borderWidth = 1
        signOutButton.layer.borderColor = UIColor(named: CommonConstant.Color.customYellow)?.cgColor
    }
    
    private func setupViews() {
        addSubview(accountLabel)
        addSubview(settingsButton)
        addSubview(accountImage)
        addSubview(tableView)
        addSubview(signOutButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            accountLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            accountLabel.topAnchor.constraint(equalTo: topAnchor, constant: 64),
            
            settingsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            settingsButton.centerYAnchor.constraint(equalTo: accountLabel.centerYAnchor),
            settingsButton.heightAnchor.constraint(equalToConstant: 20),
            settingsButton.widthAnchor.constraint(equalToConstant: 20),
            
            accountImage.heightAnchor.constraint(equalToConstant: 100),
            accountImage.widthAnchor.constraint(equalToConstant: 80),
            accountImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            accountImage.topAnchor.constraint(equalTo: accountLabel.bottomAnchor, constant: 16),
            
            tableView.topAnchor.constraint(equalTo: accountImage.bottomAnchor, constant: 80),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 160),
            
            signOutButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -120),
            signOutButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            signOutButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            
        ])
    }
}
