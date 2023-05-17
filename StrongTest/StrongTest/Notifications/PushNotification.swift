//
//  Notification.swift
//  StrongTest
//
//  Created by Damir Aliyev on 16.05.2023.
//

import UIKit

class PushNotification {
    static let shared = PushNotification()
    
    private init() {}
    
    func checkForPermission(completion: @escaping (Bool) -> Void) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized:
                completion(true)
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
                    if didAllow {
                        completion(true)
                    } else {
                        completion(false)
                    }
                }
            default:
                completion(false)
            }
        }
    }
    
    func dispatchNotification(name: String, capital: String, cca2: String) {
        let id = "notify"
        let title = name
        let body = "Capital of \(title) is \(capital)"
        
        let notificationCenter = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        
        content.title = title
        content.body = body
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [id])
        notificationCenter.add(request)
    }
}
