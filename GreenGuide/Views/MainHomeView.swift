//
//  MainHomeView.swift
//  GreenGuide
//
//  Created by Student on 17/04/2026.
//
import SwiftData
import SwiftUI

struct MainHomeView: View {
    //sores locations loaded from csv
    @State private var locations: [Location] = []

    
    @Environment(\.modelContext) private var context
    // automatically fetches all Location objects from SwiftData
    @Query private var storedLocations: [Location]

    
    var body: some View {
        Text("Locations count: \(storedLocations.count)")

        NavigationView {
            ScrollView {

                VStack {

                    if storedLocations.isEmpty {
                        VStack {
                            ProgressView()
                            Text("Loading locations...")
                        }
                    } else {
                        ForEach(storedLocations) { location in
                            NavigationLink(destination: LocationDetailView(location: location)) {
                                LocationCardView(location: location)
                            }
                        }
                    }

                }
            }
            .onAppear {
                
                //force reset once
                UserDefaults.standard.set(false, forKey: "hasLoadedData")

                let hasLoaded = UserDefaults.standard.bool(forKey: "hasLoadedData")


                    // Only load CSV ONCE
                    if !hasLoaded {

                        print("Loading CSV data...")

                        let csvLocations = CSVLoader.loadLocations()
                        print("CSV returned: \(csvLocations.count)")


                        for loc in csvLocations {
                            let newLocation = Location(
                                name: loc.name,
                                latitude: loc.latitude,
                                longitude: loc.longitude,
                                county: loc.county,
                                imageURL: loc.imageURL,
                                tags: loc.tags
                            )

                            context.insert(newLocation)
                        }


                        UserDefaults.standard.set(true, forKey: "hasLoadedData")

                }
            }
            
            
            

        }
    }
}

