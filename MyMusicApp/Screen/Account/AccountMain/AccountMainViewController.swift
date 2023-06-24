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
    private let notificationCenter = NotificationCenter()
    
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
                switch settings.authorizationStatus {
                case .authorized:
                    self.accountView.switchControl.isOn = true
                case .denied, .provisional:
                    self.accountView.switchControl.isOn = false
                case .notDetermined:
                    self.notificationCenter.requestAuthorization()
                    self.accountView.switchControl.isOn = false
                default:
                    break
                }
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
            DispatchQueue.main.async {
                self.showGuideForNotifications(titleText: "use", enableDisableText: "enable")
            }
            sender.isOn = false
        } else {
            sender.isOn = true
            self.showGuideForNotifications(titleText: "disable", enableDisableText: "disable")
        }
    }
    
    func showGuideForNotifications(titleText: String, enableDisableText: String) {
        let alert = UIAlertController(title: "Unable to \(titleText) notifications",
                                      message: "To \(enableDisableText) notifications, go to Settings and \(enableDisableText) notifications for this app.",
                                      preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default, handler: { _ in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                })
            }
        })
        alert.addAction(settingsAction)
        self.present(alert, animated: true, completion: nil)
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
