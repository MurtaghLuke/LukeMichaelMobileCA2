//
//  FavouriteManager.swift
//  GreenGuide
//
//  Created by Student on 24/04/2026.
//
import Foundation
import Combine

final class FavouriteManager: ObservableObject {
    @Published var favouriteLocations: [GreenLocation] = []

    private let key = "favouriteLocations"

    init() {
        load()
    }

    // keeps old code working
    var favouriteIDs: [String] {
        favouriteLocations.map { $0.id }
    }

    func isFavourite(_ location: GreenLocation) -> Bool {
        favouriteLocations.contains { saved in
            saved.title == location.title && saved.county == location.county
        }
    }

    func toggle(_ location: GreenLocation) {
        if isFavourite(location) {
            favouriteLocations.removeAll { saved in
                saved.title == location.title && saved.county == location.county
            }
        } else {
            favouriteLocations.append(location)
        }

        save()
    }

    private func save() {
        if let data = try? JSONEncoder().encode(favouriteLocations) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: key),
              let decoded = try? JSONDecoder().decode([GreenLocation].self, from: data) else {
            favouriteLocations = []
            return
        }

        favouriteLocations = decoded
    }
}
