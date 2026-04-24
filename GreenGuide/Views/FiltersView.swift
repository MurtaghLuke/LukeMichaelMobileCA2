//
//  FiltersView.swift
//  GreenGuide
//
//  Created by Student on 24/04/2026.
//
import SwiftUI

struct FiltersView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var selectedType = "Cottage"
    @State private var wifi = true
    @State private var garden = true
    @State private var natureTrails = true
    @State private var familyFriendly = true
    @State private var petFriendly = false

    let propertyTypes = ["Cottage", "Castle", "Coastal", "City"]

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.title2)
                        .foregroundColor(.black)
                }

                Spacer()

                Text("Filters")
                    .font(.title2)
                    .fontWeight(.bold)

                Spacer()

                Button("Clear all") {
                    selectedType = "Cottage"
                    wifi = false
                    garden = false
                    natureTrails = false
                    familyFriendly = false
                    petFriendly = false
                }
                .foregroundColor(.black)
            }
            .padding()

            Divider()

            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    Text("Experience type")
                        .font(.title2)
                        .fontWeight(.bold)

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 14) {
                        ForEach(propertyTypes, id: \.self) { type in
                            Button {
                                selectedType = type
                            } label: {
                                Text(type)
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(selectedType == type ? Color.green.opacity(0.12) : Color.white)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 14)
                                            .stroke(selectedType == type ? Color.green : Color.gray.opacity(0.3), lineWidth: 1.5)
                                    )
                                    .cornerRadius(14)
                            }
                            .foregroundColor(.black)
                        }
                    }

                    Text("Features")
                        .font(.title2)
                        .fontWeight(.bold)

                    Toggle("Wifi", isOn: $wifi)
                    Toggle("Garden", isOn: $garden)
                    Toggle("Nature trails", isOn: $natureTrails)
                    Toggle("Family friendly", isOn: $familyFriendly)
                    Toggle("Pet friendly", isOn: $petFriendly)
                }
                .padding(24)
            }

            Button {
                dismiss()
            } label: {
                Text("Show Results")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 58)
                    .background(Color.green)
                    .cornerRadius(16)
            }
            .padding()
        }
    }
}
