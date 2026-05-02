//
//  AppNotificationManager.swift
//  GreenGuide
//
//  Created by Student on 01/05/2026.
//
import Foundation
import UserNotifications
import Combine

final class AppNotificationManager: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    static let shared = AppNotificationManager()

    @Published var showBanner: Bool = false
    @Published var bannerTitle: String = ""
    @Published var bannerMessage: String = ""

    private override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }

    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .badge, .sound]
        ) { granted, error in
            if let error = error {
                print("Notification permission error: \(error.localizedDescription)")
            } else {
                print("Notification permission granted: \(granted)")
            }
        }
    }

    func notifyWishlistAdded(locationName: String) {
        showInAppBanner(locationName: locationName)
        scheduleIOSNotification(locationName: locationName)
    }

    private func showInAppBanner(locationName: String) {
        DispatchQueue.main.async {
            self.bannerTitle = "Added to Wishlist"
            self.bannerMessage = "\(locationName) has been saved to your wishlist."
            self.showBanner = true

            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.showBanner = false
            }
        }
    }
// Ensure User Defaults
    private func scheduleIOSNotification(locationName: String) {
        let content = UNMutableNotificationContent()
        content.title = "GreenGuide 🌿"
        content.body = "\(locationName) has been added to your wishlist."
        content.sound = .default
        content.badge = 1

        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 3,
            repeats: false
        )

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Notification schedule error: \(error.localizedDescription)")
            }
        }
    }

    // This makes iOS banner show even while app is open
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .sound, .badge])
    }
}
