//
//  ContentView.swift
//  GreenGuide
//
//  Created by Student on 27/03/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false




    
    var body: some View {
        NavigationView{
            ZStack {
                Color.green
                    .ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundStyle(.white.opacity(0.15))
                Circle()
                    .scale(1.35)
                    .foregroundStyle(.white)
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    ContentView()
}

//test
//test2
