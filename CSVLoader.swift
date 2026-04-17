//
//  CSVLoader.swift
//  GreenGuide
//
//  Created by Student on 17/04/2026.
//

import Foundation

class CSVLoader {
    static func loadLocations()->[Location] {

        //find csv
        guard let fileURL = Bundle.main.url(forResource: "Attractions", withExtension: "csv") else {
            print("File not found")
            return []
        }

        var locations: [Location] = []

        
        
        

        return locations
    }
}
