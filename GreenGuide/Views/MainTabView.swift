//
//  MainTabView.swift
//  GreenGuide
//
//  Created by Student on 24/04/2026.
//
import SwiftUI

struct MainTabView: View {
    @StateObject private var favouriteManager = FavouriteManager()

    var body: some View {
        TabView {
            MainHomeView()
                .environmentObject(favouriteManager)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Explore")
                }

            WishlistView()
                .environmentObject(favouriteManager)
                .tabItem {
                    Image(systemName: "heart")
                    Text("Wishlist")
                }

            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass.circle")
                    Text("Search")
                }

            InboxView()
                .tabItem {
                    Image(systemName: "bubble.left")
                    Text("Inbox")
                }

            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
        .tint(.green)
    }
}
#Preview {
    MainTabView()
}
