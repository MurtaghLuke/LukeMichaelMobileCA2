//
//  GreenGuideApp.swift
//  GreenGuide
//
//  Created by Student on 27/03/2026.
//
import SwiftUI

@main
struct GreenGuideApp: App {
    @StateObject private var notificationManager = AppNotificationManager.shared

    init() {
        AppNotificationManager.shared.requestPermission()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(notificationManager)
        }
    }
}
