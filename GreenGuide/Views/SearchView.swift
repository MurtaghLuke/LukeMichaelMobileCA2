//
//  SearchView.swift
//  GreenGuide
//
//  Created by Student on 24/04/2026.
//
import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var showFilters = false

    let recentSearches = ["Dublin City Center", "Galway Bay", "Cliffs of Moher"]
    let popularSearches = ["Cottages in Connemara", "Castles near Dublin", "Coastal walks", "Nature escapes"]

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 14) {
                Image(systemName: "xmark")
                    .font(.title2)

                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)

                    TextField("Where are you going?", text: $searchText)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(22)
            }
            .padding()

            HStack(spacing: 14) {
                Button {
                    showFilters = true
                } label: {
                    pillButton(icon: "slider.horizontal.3", text: "Filters")
                }

                pillButton(icon: "leaf", text: "Nature")
                pillButton(icon: "map", text: "Regions")
            }
            .padding(.horizontal)

            Divider()
                .padding(.top)

            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    Text("Recent Searches")
                        .font(.title2)
                        .fontWeight(.bold)

                    ForEach(recentSearches, id: \.self) { item in
                        HStack(spacing: 18) {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(.systemGray6))
                                .frame(width: 52, height: 52)
                                .overlay(
                                    Image(systemName: "mappin.circle")
                                        .foregroundColor(.gray)
                                )

                            Text(item)
                                .font(.headline)
                        }
                    }

                    Text("Popular Searches")
                        .font(.title2)
                        .fontWeight(.bold)

                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 145))], spacing: 14) {
                        ForEach(popularSearches, id: \.self) { search in
                            Text(search)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 12)
                                .background(Color(.systemGray6))
                                .cornerRadius(20)
                        }
                    }
                }
                .padding(24)
            }
        }
        .sheet(isPresented: $showFilters) {
            FiltersView()
        }
    }

    private func pillButton(icon: String, text: String) -> some View {
        HStack {
            Image(systemName: icon)
            Text(text)
                .fontWeight(.semibold)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(16)
    }
}
