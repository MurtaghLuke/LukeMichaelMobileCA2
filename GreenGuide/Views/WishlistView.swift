//
//  WishlistView.swift
//  GreenGuide
//
//  Created by Student on 24/04/2026.
//
import SwiftUI

struct WishlistView: View {
    @EnvironmentObject var favouriteManager: FavouriteManager

    var savedLocations: [GreenLocation] {
        sampleLocations.filter { favouriteManager.favouriteIDs.contains($0.id) }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Wishlist")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.horizontal)

                    if savedLocations.isEmpty {
                        VStack(spacing: 16) {
                            Image(systemName: "heart")
                                .font(.system(size: 70))
                                .foregroundColor(.green)

                            Text("No saved places yet")
                                .font(.title2)
                                .fontWeight(.bold)

                            Text("Tap the heart icon on a location to save it here.")
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, 100)
                    } else {
                        ForEach(savedLocations) { location in
                            NavigationLink {
                                LocationDetailView(location: location)
                                    .environmentObject(favouriteManager)
                            } label: {
                                LocationCardView(location: location)
                            }
                            .buttonStyle(.plain)
                            .contextMenu {
                                Button("More Info") {
                                    selectedLocation = location
                                    showLocationDetails = true
                                }

                                Button("Remove from Wishlist") {
                                    favouriteManager.toggle(location)
                                }

                            }
                        }
                    }
                }
                .padding(.top, 30)
            }
            .background(Color(.systemGroupedBackground))
        }
    }
//    //search for attraction on apple maps
//    private func openDirections(for location: GreenLocation) {
//
//
//
//    }
//}
