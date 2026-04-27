//
//  ProfileView.swift
//  GreenGuide
//
//  Created by Student on 24/04/2026.
//
import SwiftUI

struct ProfileView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn = false

    var body: some View {
        VStack(spacing: 18) {
            Image(systemName: "person.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.green)

            Text("Profile")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Manage your GreenGuide account.")
                .foregroundColor(.gray)

            Button {
                isLoggedIn = false
            } label: {
                Text("Log Out")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 220, height: 52)
                    .background(Color.green)
                    .cornerRadius(16)
            }
            .padding(.top)
        }
    }
}
