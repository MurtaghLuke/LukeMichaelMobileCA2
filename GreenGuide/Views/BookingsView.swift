//
//  BookingsView.swift
//  GreenGuide
//
//  Created by Student on 24/04/2026.
//
import SwiftUI

struct BookingsView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "house.fill")
                .font(.system(size: 60))
                .foregroundColor(.green)

            Text("Stays")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Browse your selected showcase stays.")
                .foregroundColor(.gray)
        }
    }
}
