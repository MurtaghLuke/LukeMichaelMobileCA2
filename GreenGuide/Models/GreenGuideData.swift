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
    let latitude: Double
    let longitude: Double
    let rating: String
    let description: String
    let highlights: [String]
}

let sampleLocations: [GreenLocation] = CSVLoader.loadLocations()
    
    
    
    
    //hardcoded locations
//    GreenLocation(
//        id: "cottage-galway",
//        title: "Charming Irish Cottage",
//        county: "Galway",
//        category: "Cottage",
//        imageURL: "https://images.ireland.com/media/Images/magazine/built-heritage/thatched-cottages/6fb1288924314a65b7be049b92a65f57.jpg?w=1934",
//        rating: "4.9",
//        description: "Explore a peaceful Irish cottage surrounded by nature, countryside views and traditional local charm.",
//        highlights: ["Nature trails", "Garden", "Countryside", "Quiet area"]
//    ),
//    GreenLocation(
//        id: "castle-kilkenny",
//        title: "Historic Castle Grounds",
//        county: "Kilkenny",
//        category: "Castle",
//        imageURL: "https://heritageireland.ie/assets/uploads/2020/03/Kilkenny-Castle-and-Gardens-credit-Failte-Ireland-exp.-Nov-2031.jpg",
//        rating: "5.0",
//        description: "Discover historic castle grounds and learn about Irish heritage, architecture and local culture.",
//        highlights: ["History", "Architecture", "Walking route", "Photo spot"]
//    ),
//    GreenLocation(
//        id: "coast-kerry",
//        title: "Coastal Nature Escape",
//        county: "Kerry",
//        category: "Coastal",
//        imageURL: "https://www.theross.ie/wp-content/uploads/2020/06/Eagles-Nest-Lakes-of-Killarney_master-scaled-1366x768-fp_mm-fpoff_0_0.jpg",
//        rating: "4.8",
//        description: "Enjoy coastal views, fresh air and scenic walking areas along Ireland’s beautiful coastline.",
//        highlights: ["Sea views", "Walking", "Wildlife", "Photography"]
//    )
