//
//  CSVLoader.swift
//  GreenGuide
//
//  Created by Student on 17/04/2026.
//

import Foundation

class CSVLoader {
    // nature tags
    private static let natureKeywords = [
        "nature", "outdoor", "wildlife", "walking", "hiking", "cycling", "kayaking", "surfing", "beach", "garden", "forest", "park", "island",  "climbing", "fishing", "boat"
    ]

    static func loadLocations() -> [GreenLocation] {
        // Find the CSV file inside the app bundle.
        guard let fileURL = Bundle.main.url(forResource: "Attractions", withExtension: "csv") else {
            print("Attractions.csv not found in bundle")
            return []
        }

        do {
            // Read the file as text.
            // Replace different line endings so each row is easier to split.
            let text = try String(contentsOf: fileURL, encoding: .utf8)
                .replacingOccurrences(of: "\r\n", with: "\n")
                .replacingOccurrences(of: "\r", with: "\n")
            
            // Split the file into lines.
            // The first line is the header row, so the data starts after that.
            let lines = text.split(separator: "\n", omittingEmptySubsequences: true).map(String.init)
            guard lines.count > 1 else { return [] }
            
            //store final list of attractions
            var locations: [GreenLocation] = []
            
            for line in lines.dropFirst() {
                //turn one CSV row into separate fields
                let fields = parseCSVRow(line)
                
                //skip rows that dont have enough columns
                guard fields.count > 8 else{
                    continue
                }
                
                //read in the main values we need from the CSV
                //0 = Name, 6 = County, 7 = Photo, 8 = Tags
                let name = fields[0].trimmingCharacters(in: .whitespacesAndNewlines)
                let county = fields[6].trimmingCharacters(in: .whitespacesAndNewlines)
                let imageURL = fields[7].trimmingCharacters(in: .whitespacesAndNewlines)
                let tagsText = fields[8].trimmingCharacters(in: .whitespacesAndNewlines)
                
                // Split the tags into an array for use in the app.
                let tags = tagsText
                    .split(separator: ",")
                    .map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) }
                
                
                // Only keep places that suit the nature app theme
                guard isNatureAttraction(tagsText.lowercased())
                else {
                    continue
                }
                
                
                
                //Convert the CSV row into a GreenLocation object.
                locations.append(
                    GreenLocation(
                        id: UUID().uuidString,
                        title: name,
                        county: county,
                        category: "Nature",
                        imageURL: imageURL,
                        rating: "4.5",
                        description: "Outdoor attraction in \(county), Ireland.",
                        highlights: tags
                    )
                )
            }
            
            
            return locations
        } catch {
            print("Error reading CSV file: \(error)")
            return []
        }
    }

    ////check if any of the nature keywords appear in the tags
    private static func isNatureAttraction(_ tags: String)-> Bool {
        natureKeywords.contains {
            tags.contains($0)
        }
    }



    //Split one CSV row into fields.
    //Commas inside quotes will stay inside the same field
    private static func parseCSVRow(_ line: String) -> [String] {
        var fields:[String] = []
        var current = ""
        var insideQuotes = false

        for character in line {
            if character == "\"" {
                insideQuotes.toggle()
            } else if character == "," && !insideQuotes {
                fields.append(current)
                current = ""
            } else{
                current.append(character)
            }
        }

        fields.append(current)
        return fields
    }
}
