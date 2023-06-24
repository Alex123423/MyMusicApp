//
//  NotificationCenter.swift
//  MyMusicApp
//
//  Created by Vitali Martsinovich on 2023-06-23.
//

import Foundation
import UserNotifications

struct ReceivedNotification {
    let identifier: String
    let date: Date
    let titleText: String
    let bodyText: String
}

final class NotificationsManager: NSObject {
    
    let notificationsManager = UNUserNotificationCenter.current()
    static var receivedNotifications: [ReceivedNotification] = []
    
    
    override init() {
        super.init()
        notificationsManager.delegate = self
    }
    
    func requestAuthorization() {
        notificationsManager.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification authorization granted")
            } else {
                print("Notification authorization denied")
            }
        }
    }
    
    func checkAuthorization(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            let isAuthorized = (settings.authorizationStatus == .authorized)
            completion(isAuthorized)
        }
    }
    
    func scheduleNotification(titleText: String, bodyText: String) {
        let content = UNMutableNotificationContent()
        content.title = "\(titleText) song has been downloaded"
        content.body = bodyText
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "trackDownloaded", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { [weak self] error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully.")
                let sentNotification = ReceivedNotification(identifier: request.identifier, date: Date(), titleText: request.content.title, bodyText: request.content.body)
                NotificationsManager.receivedNotifications.append(sentNotification) // Append to the static array
                print("COUNT \(NotificationsManager.receivedNotifications.count)")
                print("ARRAY AFTER APPEND \(NotificationsManager.receivedNotifications)")
                print("SENT \(sentNotification)")
            }
        }
    }
}

extension NotificationsManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier == "trackDownloaded" {
            print("Handling notification")
        }
        completionHandler()
    }
}
