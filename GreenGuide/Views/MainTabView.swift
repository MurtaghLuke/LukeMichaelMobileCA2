//
//  MainTabView.swift
//  GreenGuide
//
//  Created by Student on 24/04/2026.
//
import SwiftUI

struct MainTabView: View {
    @StateObject private var favouriteManager = FavouriteManager()
    @StateObject private var inboxManager = InboxManager.shared
    @EnvironmentObject var notificationManager: AppNotificationManager

    var body: some View {
        ZStack(alignment: .top) {
            TabView {
                MainHomeView()
                    .environmentObject(favouriteManager)
                    .environmentObject(inboxManager)
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Explore")
                    }

               WishlistView()
                    .environmentObject(favouriteManager)
                    .environmentObject(inboxManager)
                    .environmentObject(notificationManager)
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
                    .environmentObject(inboxManager)
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

            if notificationManager.showBanner {
                InAppNotificationBanner(
                    title: notificationManager.bannerTitle,
                    message: notificationManager.bannerMessage
                )
                .padding(.top, 55)
                .transition(.move(edge: .top).combined(with: .opacity))
                .zIndex(1)
            }
        }
        .animation(.spring(), value: notificationManager.showBanner)
    }
}
