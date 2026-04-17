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
              //Skip the first row and loop through rest
              for row in rows.dropFirst() {

                  // Split each row into columns
                  let columns = row.components(separatedBy: "\t")

                  // make sure row has enough columns before using data
                  if columns.count >= 9 {

                      
                      // get values from each column
                      let name = columns[0]
                      let latitude = Double(columns[3]) ?? 0.0
                      let longitude = Double(columns[4]) ?? 0.0
                      let county = columns[6]
                      let imageURL = columns[7]
                      let tags = columns[8]

                      
                      //filter only outdoor/nature locations
                      if tags.lowercased().contains("outdoor") ||
                         tags.lowercased().contains("nature") ||
                         tags.lowercased().contains("walking") {

                          // Create a Location object with the extracted data
                          let location = Location(
                              name: name,
                              latitude: latitude,
                              longitude: longitude,
                              county: county,
                              imageURL: imageURL,
                              tags: tags
                          )

                          //// Add the location to the array
                          locations.append(location)
                      }
                  }
              }

            
            
          } catch {
              // Handle errors (e.g. file not readable)
              print("Error reading CSV file: \(error)")
          }

        

        
        return locations
    }
}

