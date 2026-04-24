//
//  GreenGuideData.swift
//  GreenGuide
//
//  Created by Student on 24/04/2026.
//
import Foundation

struct GreenLocation: Identifiable, Codable, Equatable {
    let id: String
    let title: String
    let county: String
    let category: String
    let imageURL: String
    let rating: String
    let description: String
    let highlights: [String]
}

let sampleLocations: [GreenLocation] = [
    GreenLocation(
        id: "cottage-galway",
        title: "Charming Irish Cottage",
        county: "Galway",
        category: "Cottage",
        imageURL: "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee",
        rating: "4.9",
        description: "Explore a peaceful Irish cottage surrounded by nature, countryside views and traditional local charm.",
        highlights: ["Nature trails", "Garden", "Countryside", "Quiet area"]
    ),
    GreenLocation(
        id: "castle-kilkenny",
        title: "Historic Castle Grounds",
        county: "Kilkenny",
        category: "Castle",
        imageURL: "https://images.unsplash.com/photo-1598135753163-6167c1a1ad65",
        rating: "5.0",
        description: "Discover historic castle grounds and learn about Irish heritage, architecture and local culture.",
        highlights: ["History", "Architecture", "Walking route", "Photo spot"]
    ),
    GreenLocation(
        id: "coast-kerry",
        title: "Coastal Nature Escape",
        county: "Kerry",
        category: "Coastal",
        imageURL: "https://images.unsplash.com/photo-1507525428034-b723cf961d3e",
        rating: "4.8",
        description: "Enjoy coastal views, fresh air and scenic walking areas along Ireland’s beautiful coastline.",
        highlights: ["Sea views", "Walking", "Wildlife", "Photography"]
    )
]
