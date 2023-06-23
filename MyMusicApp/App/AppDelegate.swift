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
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        requestAuthorization()
        // for notifications even when app is active
        notificationCenter.delegate = self
        
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
    
    //request authorization for notifications
    func requestAuthorization() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge,]) { granted, error in
            if granted {
                print("Notification authorization granted")
                self.getNotificationSettings()
            } else {
                print("Notification authorization denied")
            }
        }
    }
    
    func getNotificationSettings() {
        notificationCenter.getNotificationSettings { settings in
            print("Notification settings: \(settings)")
        }
    }
    
    // training notification to delete
    func scheduleNotification(notificationType: String) {
        let content = UNMutableNotificationContent()
        content.title = notificationType
        content.body = "Artist Name"
        content.sound = UNNotificationSound.default
        content.badge = 1
        
        // триггер для запуска уведомления
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let identifire = "Download Notification"
        let request = UNNotificationRequest(identifier: identifire,
                                            content: content,
                                            trigger: trigger)
        notificationCenter.add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
    
    // Custom notification
    func scheduleCustomNotification() {
        // Create the notification content
        let content = UNMutableNotificationContent()
        content.title = "Notification Title"
        content.body = "Notification Body"
        content.categoryIdentifier = "musicCategory" // Use the category identifier you defined
        content.badge = 1
        
        // Add the image attachment
        if let imageURL = URL(string: "https://is5-ssl.mzstatic.com/image/thumb/Features/be/ea/3e/dj.bsqifhwq.jpg/60x60bb.jpg") {
            //            Bundle.main.url(forResource: "notification_image", withExtension: "png") {
            do {
                let attachment = try UNNotificationAttachment(identifier: "imageAttachment", url: imageURL, options: nil)
                content.attachments = [attachment]
            } catch {
                print("Error adding image attachment: \(error)")
            }
        }
    }
    
    // temp notification code
    func scheduleNotification(for trackURL: URL?) {
        guard let trackURL = trackURL else {
            return
        }
        
        let content = UNMutableNotificationContent()
        content.title = "Track Downloaded"
        content.body = "The track sample has been successfully downloaded."
        content.sound = UNNotificationSound.default
        
        if let attachment = try? UNNotificationAttachment(identifier: "trackSample", url: trackURL, options: nil) {
            content.attachments = [attachment]
        }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let request = UNNotificationRequest(identifier: "trackDownloaded", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully.")
            }
        }
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    // for notifications even when app is active
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
    
    // try to open notification controller
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if response.notification.request.identifier == "trackDownloaded" {
            print("Handling notification")
        }
        completionHandler()
    }
}
