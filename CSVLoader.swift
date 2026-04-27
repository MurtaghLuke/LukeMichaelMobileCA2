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

        
        do {
              //read contents into a string
              let data = try String(contentsOf: fileURL, encoding: .utf8)
              // Split the file into rows with newline characters
              let rows = data.components(separatedBy: "\n")

            
            for row in rows.dropFirst() {

                let columns = row.components(separatedBy: ",")

                if columns.count >= 9 {

                    let name = columns[0].replacingOccurrences(of: "\"", with: "")
                    let latitude = Double(columns[3].replacingOccurrences(of: "\"", with: "")) ?? 0.0
                    let longitude = Double(columns[4].replacingOccurrences(of: "\"", with: "")) ?? 0.0
                    let county = columns[6].replacingOccurrences(of: "\"", with: "")
                    let imageURL = columns[7]
                        .replacingOccurrences(of: "\"", with: "")
                        .trimmingCharacters(in: .whitespacesAndNewlines)
                    let tags = columns[8].replacingOccurrences(of: "\"", with: "")

                    let cleanTags = tags.lowercased()

                    // only keep nature/outdoor attractions
                    if cleanTags.contains("outdoor") ||
                       cleanTags.contains("nature") ||
                       cleanTags.contains("walk") ||
                       cleanTags.contains("trail") {

                    // skip bad urls
                    if !imageURL.starts(with: "http") {
                        continue
                    }
                        
                        let location = Location(
                            name: name,
                            latitude: latitude,
                            longitude: longitude,
                            county: county,
                            imageURL: imageURL,
                            tags: tags
                        )

                        locations.append(location)
                    }
                }
            }

            
            
          } catch {
              print("Error reading CSV file: \(error)")
          }

        

        
        return Array(locations.prefix(200))
    }
}

