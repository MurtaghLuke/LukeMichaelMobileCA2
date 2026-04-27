//
//  AuthManager.swift
//  GreenGuide
//
//  Created by Student on 24/04/2026.
//
import Foundation

struct AppUser: Codable {
    let fullName: String
    let email: String
    let password: String
}

final class AuthManager {
    static let shared = AuthManager()
    private let usersKey = "registeredUsers"

    private init() {}

    func signUp(fullName: String, email: String, password: String) -> Bool {
        var users = getUsers()
        let cleanEmail = email.lowercased().trimmingCharacters(in: .whitespaces)

        if users.contains(where: { $0.email.lowercased() == cleanEmail }) {
            return false
        }

        let newUser = AppUser(
            fullName: fullName,
            email: cleanEmail,
            password: password
        )

        users.append(newUser)
        saveUsers(users)
        return true
    }

    func login(email: String, password: String) -> Bool {
        let cleanEmail = email.lowercased().trimmingCharacters(in: .whitespaces)
        let users = getUsers()

        return users.contains {
            $0.email.lowercased() == cleanEmail && $0.password == password
        }
    }

    private func getUsers() -> [AppUser] {
        guard let data = UserDefaults.standard.data(forKey: usersKey) else {
            return []
        }

        return (try? JSONDecoder().decode([AppUser].self, from: data)) ?? []
    }

    private func saveUsers(_ users: [AppUser]) {
        if let data = try? JSONEncoder().encode(users) {
            UserDefaults.standard.set(data, forKey: usersKey)
        }
    }
}
