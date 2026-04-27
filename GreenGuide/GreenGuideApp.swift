//
//  GreenGuideApp.swift
//  GreenGuide
//
//  Created by Student on 27/03/2026.
//
import SwiftData
import SwiftUI

@main
struct GreenGuideApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        //enables swift data for app
        .modelContainer(for: Location.self)

    }
}
