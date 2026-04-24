//
//  LocationDetailView.swift
//  GreenGuide
//
//  Created by Student on 17/04/2026.
//

import SwiftUI

struct LocationDetailView: View {
    @EnvironmentObject var favouriteManager: FavouriteManager
    @Environment(\.dismiss) private var dismiss

    let location: GreenLocation

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ZStack(alignment: .top) {
                    AsyncImage(url: URL(string: location.imageURL)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Rectangle()
                            .fill(Color.green.opacity(0.15))
                            .overlay(ProgressView())
                    }
                    .frame(height: 300)
                    .clipped()

                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "arrow.left")
                                .font(.title2)
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.white.opacity(0.9))
                                .clipShape(Circle())
                        }

                        Spacer()

                        Button {
                            favouriteManager.toggle(location)
                        } label: {
                            Image(systemName: favouriteManager.isFavourite(location) ? "heart.fill" : "heart")
                                .font(.title2)
                                .foregroundColor(favouriteManager.isFavourite(location) ? .red : .black)
                                .padding()
                                .background(Color.white.opacity(0.9))
                                .clipShape(Circle())
                        }
                    }
                    .padding()
                }

                VStack(alignment: .leading, spacing: 18) {
                    Text(location.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    HStack(spacing: 14) {
                        Label(location.rating, systemImage: "star.fill")
                        Label("\(location.county), Ireland", systemImage: "mappin.circle")
                    }
                    .foregroundColor(.secondary)

                    Divider()

                    Text("About this place")
                        .font(.title2)
                        .fontWeight(.bold)

                    Text(location.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .lineSpacing(5)

                    Divider()

                    Text("What this place offers")
                        .font(.title2)
                        .fontWeight(.bold)

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 18) {
                        ForEach(location.highlights, id: \.self) { item in
                            Label(item, systemImage: "leaf")
                                .foregroundColor(.primary)
                        }
                    }

                    Button {
                        favouriteManager.toggle(location)
                    } label: {
                        Text(favouriteManager.isFavourite(location) ? "Remove from Wishlist" : "Save to Wishlist")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 58)
                            .background(Color.green)
                            .cornerRadius(16)
                    }
                    .padding(.top, 20)
                }
                .padding(24)
            }
        }
        .ignoresSafeArea(edges: .top)
        .navigationBarBackButtonHidden(true)
    }
}
