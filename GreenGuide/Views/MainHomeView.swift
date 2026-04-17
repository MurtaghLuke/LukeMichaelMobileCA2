//
//  MainHomeView.swift
//  GreenGuide
//
//  Created by Student on 17/04/2026.
//

import SwiftUI

struct MainHomeView: View {
//sample locations
    let locations = [
        Location(name: "Cliffs of Moher", imageName: "x"),
        Location(name: "Benbulben", imageName: "x"),
        Location(name: "Glendalough", imageName: "x")]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 15) {
                     ForEach(locations) {location in
                         NavigationLink(destination: LocationDetailView(location: location)) {
                             LocationCardView(location: location)
                         }
                     }
                 }
                 .padding(.top)
            }
            .navigationTitle("Explore Ireland")
        }
    }
}

