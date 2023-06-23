//
//  AccountMainViewController.swift
//  MyMusicApp
//
//  Created by Vitali Martsinovich on 2023-06-13.
//

import UIKit
import Firebase
import GoogleSignIn

final class AccountMainViewController: UIViewController {
    
    private let accountView = AccountMainView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        accountView.updateAvatarImage()
        checkNotificationAuthorization()
    }
    
    func checkNotificationAuthorization() {
        UNUserNotificationCenter.current().getNotificationSettings { [weak self] settings in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.accountView.switchControl.isOn = (settings.authorizationStatus == .authorized)
            }
        }
    }
}

//MARK: - Buttons' delegates

extension AccountMainViewController: AccountMainViewDelegate {
    
    func accountView(_ view: AccountMainView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let playlistVC = PlaylistViewController()
            playlistVC.title = "My Playlist"
            navigationController?.pushViewController(playlistVC, animated: true)
        case 1:
            let notificationtVC = NotificationsViewController()
            navigationController?.pushViewController(notificationtVC, animated: true)
        case 2:
            let downloadVC = DownloadViewController()
            navigationController?.pushViewController(downloadVC, animated: true)
            print("transition to Download")
        default:
            break
        }
    }
    
    func accountView(_ view: AccountMainView, didTapSignOutButton button: UIButton) {
        
        if GIDSignIn.sharedInstance.currentUser != nil {
            GIDSignIn.sharedInstance.signOut()
        } else {
            do {
                try Auth.auth().signOut()
            } catch let error {
                print("Error. logOutButtonPress. already logged out: ", error.localizedDescription)
            }
        }
        self.dismiss(animated: true)
    }
    
    func accountView(_ view: AccountMainView, didTapSettingsButton button: UIButton) {
        let settingsVC = SettingsViewController()
        settingsVC.title = "Edit"
        settingsVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    func accountView(_ view: AccountMainView, didTapToggle sender: UISwitch) {
        if sender.isOn {
            // Enable notifications
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                if settings.authorizationStatus == .authorized {
                    print("Notifications are already authorized")
                } else {
//                    self.requestAuthorization()
                }
            }
        } else {
            // Disable notifications
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        }
    }
}
    
    extension AccountMainViewController {
        
        private func setDelegates() {
            accountView.delegate = self
        }
        
        private func setupViews() {
            view.backgroundColor = .maBackground
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
