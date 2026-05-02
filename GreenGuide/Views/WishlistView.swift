//
//  WishlistView.swift
//  GreenGuide
//
//  Created by Student on 24/04/2026.
//
import SwiftUI

struct WishlistView: View {
    @EnvironmentObject var favouriteManager: FavouriteManager
    @EnvironmentObject var inboxManager: InboxManager
    @EnvironmentObject var notificationManager: AppNotificationManager
    @Environment(\.openURL) private var openURL
    // Stores the card chosen from the long press menu
    @State private var selectedLocation: GreenLocation?
    // Opens the selected card in the detail screen from the context menu
    @State private var showLocationDetails = false

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

                    if favouriteManager.favouriteLocations.isEmpty {
                        emptyState
                    } else {
                        ForEach(favouriteManager.favouriteLocations) { location in
                            NavigationLink {
                                LocationDetailView(location: location)
                                    .environmentObject(favouriteManager)
                                    .environmentObject(notificationManager)
                                    .environmentObject(inboxManager)
                            } label: {
                                LocationCardView(location: location)
                            }
                            .buttonStyle(.plain)
                            //press and hold
                            .contextMenu {
                                Button("More Info") {
                                    selectedLocation = location
                                    showLocationDetails = true
                                }

                                Button("Remove from Wishlist") {
                                    favouriteManager.toggle(location)
                                }

                                Button("Directions") {
                                    openDirections(for: location)
                                }
                            }
                        }
                    }
                }
                .padding(.top, 30)
            }
            .background(Color(.systemGroupedBackground))
            // Push the selected location after choosing "More Info" from the menu.
            .navigationDestination(isPresented: $showLocationDetails) {
                if let selectedLocation {
                    LocationDetailView(location: selectedLocation)
                        .environmentObject(favouriteManager)
                }
            }
        }
    }

    private var emptyState: some View {
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
                .padding(.horizontal)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 100)
    }
}

#Preview {
    WishlistView()
        .environmentObject(FavouriteManager())
        .environmentObject(InboxManager.shared)
        .environmentObject(AppNotificationManager.shared)
    private func openDirections(for location: GreenLocation) {
        //open maps with the coordinates loaded from the CSV.
        let name = location.title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

        guard let url = URL(
            string: "http://maps.apple.com/?ll=\(location.latitude),\(location.longitude)&q=\(name)"
        ) else {
            return
        }

        openURL(url)
    }
}
