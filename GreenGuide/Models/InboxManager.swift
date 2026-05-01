//
//  InboxManager.swift
//  GreenGuide
//
//  Created by Student on 01/05/2026.
//
import Foundation
import Combine
// Struct to compelete inbox messages
struct InboxMessage: Identifiable, Codable {
    let id: UUID
    let sender: String
    let title: String
    let message: String
    let date: Date
    var isRead: Bool
}

final class InboxManager: ObservableObject {
    static let shared = InboxManager()

    @Published var messages: [InboxMessage] = []

    private let key = "greenGuideInboxMessages" // Only ibox section

    private init() {
        loadMessages()

        if messages.isEmpty {
            seedMessages()
        }
    }
    

    func addMessage(title: String, message: String, sender: String = "GreenGuide") {
        let newMessage = InboxMessage(
            id: UUID(),
            sender: sender,
            title: title,
            message: message,
            date: Date(),
            isRead: false
        ) // Most go through its criterias

        messages.insert(newMessage, at: 0)
        saveMessages()
    }

    func markAsRead(_ message: InboxMessage) {
        if let index = messages.firstIndex(where: { $0.id == message.id }) {
            messages[index].isRead = true
            saveMessages()
        }
    }

    private func seedMessages() { // When user is logged in with access to inbox
        messages = [
            InboxMessage(
                id: UUID(),
                sender: "GreenGuide",
                title: "Welcome to GreenGuide 🌿",
                message: "Start exploring Irish locations and save your favourite places to your wishlist.",
                date: Date(),
                isRead: false
            )
        ]

        saveMessages()
    }

    private func saveMessages() {
        if let data = try? JSONEncoder().encode(messages) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    private func loadMessages() {
        guard let data = UserDefaults.standard.data(forKey: key),
              let decoded = try? JSONDecoder().decode([InboxMessage].self, from: data) else {
            messages = []
            return
        }

        messages = decoded
    }
}
