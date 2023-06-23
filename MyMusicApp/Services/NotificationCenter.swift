//
//  NotificationCenter.swift
//  MyMusicApp
//
//  Created by Vitali Martsinovich on 2023-06-23.
//

import Foundation
import UserNotifications

class NotificationCenter: NSObject {
    let notificationCenter = UNUserNotificationCenter.current()
    var receivedNotifications: [UNNotification] = []

    override init() {
        super.init()
        notificationCenter.delegate = self
    }

    func requestAuthorization() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification authorization granted")
            } else {
                print("Notification authorization denied")
            }
        }
    }

    func scheduleNotification(titleText: String, bodyText: String) {
        let content = UNMutableNotificationContent()
        content.title = "\(titleText) song has been downloaded"
        content.body = bodyText
        content.sound = UNNotificationSound.default
        
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

extension NotificationCenter: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier == "trackDownloaded" {
            print("Handling notification")
            receivedNotifications.append(response.notification)
            print(receivedNotifications)
        }
        completionHandler()
    }
}
