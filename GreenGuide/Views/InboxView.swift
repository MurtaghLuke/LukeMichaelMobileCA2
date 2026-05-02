//
//  InboxView.swift
//  GreenGuide
//
//  Created by Student on 24/04/2026.
//
import SwiftUI

struct InboxView: View {
    @EnvironmentObject var inboxManager: InboxManager

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                if inboxManager.messages.isEmpty {
                    emptyState
                } else {
                    List {
                        ForEach(inboxManager.messages) { message in
                            Button {
                                inboxManager.markAsRead(message)
                            } label: {
                                InboxMessageRow(message: message)
                            }
                            .buttonStyle(.plain)
                            //delete message with swipe
                            .swipeActions(allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    inboxManager.deleteMessage(message)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Inbox")
        }
    }

    private var emptyState: some View {
        VStack(spacing: 16) {
            Spacer()

            Image(systemName: "bubble.left.fill")
                .font(.system(size: 60))
                .foregroundColor(.green)

            Text("Inbox")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Wishlist updates and GreenGuide messages will appear here.")
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()
        }
    }
}

struct InboxMessageRow: View {
    let message: InboxMessage

    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            Circle()
                .fill(message.isRead ? Color.gray.opacity(0.3) : Color.green)
                .frame(width: 12, height: 12)
                .padding(.top, 7)

            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(message.title)
                        .font(.headline)

                    Spacer()

                    Text(message.date, style: .time)
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                Text(message.sender)
                    .font(.subheadline)
                    .foregroundColor(.green)

                Text(message.message)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
            }
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    InboxView()
        .environmentObject(InboxManager.shared)
}
