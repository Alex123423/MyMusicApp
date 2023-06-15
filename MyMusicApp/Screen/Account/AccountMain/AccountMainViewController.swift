//
//  AccountMainViewController.swift
//  MyMusicApp
//
//  Created by Vitali Martsinovich on 2023-06-13.
//

import UIKit
import Firebase

final class AccountMainViewController: UIViewController {
    
    private let accountView = AccountMainView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setDelegates()
        print(navigationController?.viewControllers)
    }
}

//MARK: - Buttons' delegates

extension AccountMainViewController: AccountMainViewDelegate {
    
    func accountView(_ view: AccountMainView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            print("transition to Playlist")
            //            let playlistVC = PlaylistVC // add playlic viewcontroller
            //            navigationController?.pushViewController(playlistVC, animated: true)
            print(indexPath.row)
        case 1:
            let notificationtVC = NotificationsViewController()
            navigationController?.pushViewController(notificationtVC, animated: true)
        case 2:
            print("transition to Download")
        default:
            break
        }
    }
    
    func accountView(_ view: AccountMainView, didTapSignOutButton button: UIButton) {
        print("sign out tapped")
        do {
            try Auth.auth().signOut()
        } catch let error {
            print("Error. logOutButtonPress. already logged out: ", error.localizedDescription)
            return
        }
        self.dismiss(animated: true)
    }
    
    func accountView(_ view: AccountMainView, didTapSettingsButton button: UIButton) {
        let settingsVC = SettingsViewController()
        settingsVC.title = "Edit"
        settingsVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    func accountView(_ view: AccountMainView, didTapToggle sender: UISwitch) {
        if sender.isOn {
            print("ON")
        } else {
            print("OFF")
        }
    }
}

extension AccountMainViewController {
    
    private func setDelegates() {
        accountView.delegate = self
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor(named: "CommonConstant.Color.background")
        view.addSubview(accountView)
    }
    
    private func setupConstraints() {
        accountView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            accountView.topAnchor.constraint(equalTo: view.topAnchor),
            accountView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            accountView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            accountView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}
