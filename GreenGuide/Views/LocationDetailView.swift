//
//  LocationDetailView.swift
//  GreenGuide
//
//  Created by Student on 17/04/2026.
//

import SwiftUI

struct LocationDetailView: View {
    let location: Location

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {

                Image(location.imageName)
                    .resizable()
                    .scaledToFill()
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
