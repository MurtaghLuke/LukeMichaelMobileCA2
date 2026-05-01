//
//  InAppNotificationBanner.swift
//  GreenGuide
//
//  Created by Student on 01/05/2026.
//
import SwiftUI

struct InAppNotificationBanner: View {
    let title: String
    let message: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "heart.fill")
                .foregroundColor(.white)
                .font(.title2)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)

                Text(message)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.9))
                    .lineLimit(2)
            }

            Spacer()
        }
        .padding()
        .background(Color.green)
        .cornerRadius(18)
        .shadow(radius: 8)
        .padding(.horizontal)
    }
}
