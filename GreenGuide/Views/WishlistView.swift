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
                        }
                    }
                }
                .padding(.top, 30)
            }
            .background(Color(.systemGroupedBackground))
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
}
