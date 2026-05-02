//
//  MainHomeView.swift
//  GreenGuide
//
//  Created by Student on 17/04/2026.
//

import SwiftUI

struct MainHomeView: View {
    @EnvironmentObject var favouriteManager: FavouriteManager
    @EnvironmentObject var notificationManager: AppNotificationManager
    @EnvironmentObject var inboxManager: InboxManager

    @Environment(\.openURL) private var openURL
    //hold attrations from csvloader
    @State private var locations: [GreenLocation] = []
    // stores the card chosen from the long press menu.
    @State private var selectedLocation: GreenLocation?
    // opens the selected card in the detail screen from context menu
    @State private var showLocationDetails = false

    //filter keywords for home page
    private let natureKeywords = [
        "nature", "outdoor", "wildlife", "walking", "hiking", "cycling", "kayaking", "surfing", "beach", "garden", "forest", "park", "island",  "climbing", "fishing", "boat"
    ]

    ////filters locations by nature related keywords
    ////combines category and highlights into one searchable string
    private var filteredLocations: [GreenLocation] {
        locations.filter { location in
            let searchableText = ([location.category] + location.highlights)
                .joined(separator: " ")
                .lowercased()

            // Return if any keyword matches location
            return natureKeywords.contains {
                searchableText.contains($0)
            }
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 24) {
                    header
                    searchBar

                    Text("Featured Places")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)

                    /// give message if no locations match filter
                    if filteredLocations.isEmpty {
                        Text("No outdoor attractions found")
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                    } else {
                        //////Loop through filtered locations and show each as a card
                        ForEach(filteredLocations) { location in
                                //go to details view when tapped
                            NavigationLink {
                                LocationDetailView(location: location)
                                    .environmentObject(favouriteManager)
                                    .environmentObject(notificationManager)
                                    .environmentObject(inboxManager)
                            } label: {
                                LocationCardView(location: location)
                            }
                            .buttonStyle(.plain)
                            //long press opens context menu
                            .contextMenu {
                                Button("More Info") {
                                    selectedLocation = location
                                    showLocationDetails = true
                                }
                                
                                Button(
                                    favouriteManager.isFavourite(location) ? "Remove from Wishlist" : "Add to Wishlist"
                                ) {
                                    favouriteManager.toggle(location)
                                }
                                

                                Button("Directions") {
                                    openDirections(for: location)
                                }
                            }
                        }
                    }
                }
                .padding(.top, 20)
            }
            .background(Color(.systemGroupedBackground))
            // use the selected location after pressing more info in context menu
            .navigationDestination(isPresented: $showLocationDetails) {
                if let selectedLocation {
                    LocationDetailView(location:selectedLocation)
                        .environmentObject(favouriteManager)
                        .environmentObject(notificationManager)
                        .environmentObject(inboxManager)
                }
            }
        }
        .task {
            locations = CSVLoader.loadLocations()
        }
    }

    private var header: some View {
        HStack {
            Text("Greenguide")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.green)
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

    /////https://developer.apple.com/library/archive/featuredarticles/iPhoneURLScheme_Reference/MapLinks/MapLinks.html
    //open apple maps with the coordinates in the csv
    private func openDirections(for location: GreenLocation){
        let name = location.title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            //build maps url with lat and long
        guard let url = URL(
            string: "http://maps.apple.com/?ll=\(location.latitude),\(location.longitude)&q=\(name)"
        ) else{
            return
        }

        openURL(url)
    }
}

#Preview {
    MainHomeView()
        .environmentObject(FavouriteManager())
        .environmentObject(AppNotificationManager.shared)
        .environmentObject(InboxManager.shared)
}
