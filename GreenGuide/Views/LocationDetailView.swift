//
//  LocationDetailView.swift
//  GreenGuide
//
//  Created by Student on 17/04/2026.
//

import SwiftUI

struct LocationDetailView: View {
    // gets the selected location from the last screen.
    let location: Location

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {

                // AsyncImage loads image from a URL
                AsyncImage(url: URL(string: location.imageURL)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    //shows when image is loading
                    ProgressView()
                }
                .frame(height: 250)
                .clipped()


                
                Text(location.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                Text("Description for location here")
                    .padding(.horizontal)
            }
        }
        .navigationTitle(location.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
