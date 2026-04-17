//
//  HomeView.swift
//  GreenGuide
//
//  Created by Student on 27/03/2026.
//

//Splash screen

import SwiftUI


import SwiftUI

struct HomeView: View {
    @State private var isActive = false
    @State private var opacity = 0.0

    var body: some View {
        if isActive {
            MainHomeView()
        } else {
            ZStack {
                Color.white
                    .ignoresSafeArea()

                VStack {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300)

                }
                .opacity(opacity)
                .onAppear {
                    //fade in
                    withAnimation(.easeIn(duration: 0.5)) {
                        opacity = 1
                    }

                    // Move to home screen
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        isActive = true
                    }
                }
            }
        }
    }
}
