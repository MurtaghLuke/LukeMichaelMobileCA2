//
//  MainHomeView.swift
//  GreenGuide
//
//  Created by Student on 17/04/2026.
//

import SwiftUI

struct MainHomeView: View {
    @EnvironmentObject var favouriteManager: FavouriteManager

    let categories = [
        ("Cottages", "house.fill"),
        ("Castles", "building.columns.fill"),
        ("Coastal", "water.waves"),
        ("County", "map.fill"),
        ("Dublin", "building.2.fill")
    ]

    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    header
                    searchBar
                    categoryRow

                    Text("Featured Places")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)

                    ForEach(sampleLocations) { location in
                        NavigationLink {
                            LocationDetailView(location: location)
                                .environmentObject(favouriteManager)
                        } label: {
                            LocationCardView(location: location)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.top, 20)
            }
            .background(Color(.systemGroupedBackground))
        }
    }

    private var header: some View {
        HStack {
            Text("Greenguide")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.green)

            Spacer()

            Image(systemName: "mappin.circle")
                .font(.title)
                .foregroundColor(.gray)
        }
        .padding(.horizontal)
    }

    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)

            Text("Where are you going?")
                .foregroundColor(.gray)

            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(22)
        .padding(.horizontal)
    }

    private var categoryRow: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 22) {
                ForEach(categories, id: \.0) { category in
                    VStack(spacing: 8) {
                        Circle()
                            .fill(Color.gray.opacity(0.12))
                            .frame(width: 62, height: 62)
                            .overlay(
                                Image(systemName: category.1)
                                    .font(.title2)
                                    .foregroundColor(.green)
                            )

                        Text(category.0)
                            .font(.caption)
                            .foregroundColor(.black)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    MainHomeView()
        .environmentObject(FavouriteManager())
}
