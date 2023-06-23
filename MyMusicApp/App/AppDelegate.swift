//
//  AppDelegate.swift
//  MyMusicApp
//
//  Created by Alexey Davidenko on 06.06.2023.
//

import UIKit
import Firebase
import GoogleSignIn
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let notificationCenter = NotificationCenter()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        notificationCenter.requestAuthorization()

        return true
    }
    
    // set badge to 0
    func applicationDidBecomeActive(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    // google authorization
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
    
}
