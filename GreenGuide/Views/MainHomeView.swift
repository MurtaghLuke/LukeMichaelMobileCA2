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
        Location(name: "Guinness Storehouse", imageName: "x"),
        Location(name: "Glendalough", imageName: "x")
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(locations) { location in
                        LocationCardView(location: location)
                    }
                }
            }
            .navigationTitle("Explore Ireland")
        }
    }
}

