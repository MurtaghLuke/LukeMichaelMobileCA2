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
            VStack(spacing: 0) {
                heroImage

                VStack(alignment: .leading, spacing: 20) {
                    titleSection
                    Divider()
                    aboutSection
                    Divider()
                    offersSection
                    wishlistButton
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(24)
                .background(Color.white)
            }
        }
        .background(Color(.systemGroupedBackground))
        .ignoresSafeArea(edges: .top)
        .navigationBarBackButtonHidden(true)
    }

    private var heroImage: some View {
        ZStack(alignment: .top) {
            GeometryReader { geo in
                AsyncImage(url: URL(string: location.imageURL)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()

                    default:
                        Image("cottage")
                            .resizable()
                            .scaledToFill()
                    }
                }
                .frame(width: geo.size.width, height: 320)
                .clipped()
            }
            .frame(height: 320)

            HStack {
                Button {
                    dismiss()
                } label: {
                    circleIcon("arrow.left")
                }

                Spacer()

                Button {
                    favouriteManager.toggle(location)
                } label: {
                    circleIcon(favouriteManager.isFavourite(location) ? "heart.fill" : "heart",
                               color: favouriteManager.isFavourite(location) ? .red : .black)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 55)
        }
    }

    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(location.title)
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.primary)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)

            HStack(spacing: 12) {
                Label(location.rating, systemImage: "star.fill")
                    .foregroundColor(.secondary)

                Label("\(location.county), Ireland", systemImage: "mappin.circle")
                    .foregroundColor(.secondary)
            }
            .font(.subheadline)
        }
    }

    private var aboutSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("About this place")
                .font(.title2)
                .fontWeight(.bold)

            Text(location.description)
                .font(.body)
                .foregroundColor(.secondary)
                .lineSpacing(5)
                .fixedSize(horizontal: false, vertical: true)
        }
    }

    private var offersSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("What this place offers")
                .font(.title2)
                .fontWeight(.bold)

            VStack(alignment: .leading, spacing: 12) {
                ForEach(location.highlights, id: \.self) { item in
                    HStack(spacing: 10) {
                        Image(systemName: "leaf.fill")
                            .foregroundColor(.green)
                            .frame(width: 24)

                        Text(item)
                            .font(.body)
                            .foregroundColor(.primary)

                        Spacer()
                    }
                }
            }
        }
    }

    private var wishlistButton: some View {
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
        .padding(.top, 10)
    }

    private func circleIcon(_ name: String, color: Color = .black) -> some View {
        Image(systemName: name)
            .font(.title3)
            .foregroundColor(color)
            .frame(width: 46, height: 46)
            .background(Color.white.opacity(0.95))
            .clipShape(Circle())
            .shadow(color: .black.opacity(0.12), radius: 4, x: 0, y: 2)
    }
}
