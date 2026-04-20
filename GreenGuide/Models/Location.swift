//
//  Location.swift
//  GreenGuide
//
//  Created by Student on 27/03/2026.
//
import Foundation
import SwiftData


//struct Location: Identifiable{
//    let id = UUID()
//    let name: String
//    let latitude: Double
//    let longitude: Double
//    let county: String
//    let imageURL: String
//    let tags: String
//}

@Model
class Location {
    var name: String
    var latitude: Double
    var longitude: Double
    var county: String
    var imageURL: String
    var tags: String

    init(name: String, latitude: Double, longitude: Double, county: String, imageURL: String, tags: String) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.county = county
        self.imageURL = imageURL
        self.tags = tags
    }
}
