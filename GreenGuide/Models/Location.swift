//
//  Location.swift
//  GreenGuide
//
//  Created by Student on 27/03/2026.
//
import Foundation


struct Location: Identifiable{
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    let county: String
    let imageURL: String
    let tags: String
}
