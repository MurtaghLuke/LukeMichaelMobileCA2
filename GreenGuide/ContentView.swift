//
//  ContentView.swift
//  GreenGuide
//
//  Created by Student on 27/03/2026.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    @AppStorage("isLoggedIn") private var isLoggedIn = false

    var body: some View {
        if !hasSeenOnboarding {
            OnboardingView()
        } else if !isLoggedIn {
            LoginView()
        } else {
            MainTabView()
        }
    }
} //test2
