//
//  InboxView.swift
//  GreenGuide
//
//  Created by Student on 24/04/2026.
//
import SwiftUI

struct InboxView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "bubble.left.fill")
                .font(.system(size: 60))
                .foregroundColor(.green)

            Text("Inbox")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Messages and updates will appear here.")
                .foregroundColor(.gray)
        }
    }
}
