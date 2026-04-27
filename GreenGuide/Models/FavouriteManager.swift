//
//  FavouriteManager.swift
//  GreenGuide
//
//  Created by Student on 24/04/2026.
//
import Foundation
import Combine

final class FavouriteManager: ObservableObject {
    @Published var favouriteIDs: [String] = []

    private let key = "favouriteLocations"

    init() {
        load()
    }

    func isFavourite(_ location: GreenLocation) -> Bool {
        favouriteIDs.contains(location.id)
    }

    func toggle(_ location: GreenLocation) {
        if isFavourite(location) {
            favouriteIDs.removeAll { $0 == location.id }
        } else {
            favouriteIDs.append(location.id)
        }

        save()
    }

    private func save() {
        UserDefaults.standard.set(favouriteIDs, forKey: key)
    }

    private func load() {
        favouriteIDs = UserDefaults.standard.stringArray(forKey: key) ?? []
    }
}
