//
//  Account.swift
//  MyMusicApp
//
//  Created by Alexey Davidenko on 11.06.2023.
//

import UIKit

enum AccountConstant {
    
    enum Text {
        //Title
        static let account = "Account"
        static let library = "Library"
        static let edit = "Edit"
        static let notification = "Notification"
        static let today = "Today"

        //Label
        static let myPlaylist = "My playlist"
        static let download = "Download"
        static let userName = "Username"
        static let email = "Email"
        static let gender = "Gender"
        static let dateOfBirthday = "Date of birthday"

        //Button
        static let singOutButton = "SING OUT"
        static let changePasswordButton = "Change password"
    }
    
    enum Symbol {
        static let settings = UIImage(systemName: "gearshape")
        static let playlist = UIImage(named: "playlist-icon")
        static let notification = UIImage(named: "notification-icon")
        static let download = UIImage(named: "download-icon")
        static let cameraImage = UIImage(systemName: "camera.fill")

    }
    
    enum Image {
        static let accountImage = UIImage(named: "accountImage")
        static let avatarImage = UIImage(named: "avatarImage")
    }
}
