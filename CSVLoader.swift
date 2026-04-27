//
//  CSVLoader.swift
//  GreenGuide
//
//  Created by Student on 17/04/2026.
//

import Foundation

class CSVLoader {
    static func loadLocations() -> [GreenLocation] {
        guard let fileURL = Bundle.main.url(forResource: "Attractions", withExtension: "csv") else {
            print("Attractions.csv not found in bundle")
            return []
        }

        do {
            var text = try String(contentsOf: fileURL, encoding: .utf8)
            // Normalize line endings
            text = text.replacingOccurrences(of: "\r\n", with: "\n")
                       .replacingOccurrences(of: "\r", with: "\n")

            var lines = text.split(separator: "\n", omittingEmptySubsequences: true).map(String.init)
            guard !lines.isEmpty else { return [] }

            // Parse header and create a lookup for column indices
            let headers = parseCSVRow(lines.removeFirst())
            let indexFor = Dictionary(uniqueKeysWithValues: headers.enumerated().map { ($1.lowercased(), $0) })

            func value(_ key: String, in fields: [String]) -> String {
                guard let idx = indexFor[key.lowercased()], idx < fields.count else { return "" }
                return fields[idx]
            }

            var locations: [GreenLocation] = []
            locations.reserveCapacity(lines.count)

            for line in lines {
                let fields = parseCSVRow(line)
                if fields.isEmpty { continue }

                // Adjust these keys to match your CSV headers exactly
                let name = value("name", in: fields)
                let latitude = Double(value("latitude", in: fields)) ?? 0
                let longitude = Double(value("longitude", in: fields)) ?? 0
                let county = value("county", in: fields)
                let imageURL = value("imageurl", in: fields)
                let tags = value("tags", in: fields).lowercased()

                // Basic quality checks
                if name.isEmpty || county.isEmpty { continue }

                // If you only want nature/outdoor, filter here (optional)
                let isNature = tags.contains("nature") || tags.contains("outdoor")

                // If you want to enforce nature/outdoor only, uncomment:
                // guard isNature else { continue }

                // If imageURL is missing/invalid, let AsyncImage fallback handle it
                let highlights = tags
                    .split(whereSeparator: { $0 == ";" || $0 == "," || $0 == " " })
                    .map { String($0).trimmingCharacters(in: .whitespaces) }
                    .filter { !$0.isEmpty }

                let location = GreenLocation(
                    id: UUID().uuidString,  // use a stable "id" column if your CSV has one
                    title: name,
                    county: county,
                    category: isNature ? "Outdoor" : "Attraction",
                    imageURL: imageURL.trimmingCharacters(in: .whitespacesAndNewlines),
                    rating: "4.5", // placeholder if CSV has no rating
                    description: "Attraction in \(county).",
                    highlights: highlights
                )

                locations.append(location)
            }

            print("Loaded locations: \(locations.count)")
            // You can remove the limit if you want them all
            return Array(locations.prefix(200))
        } catch {
            print("Error reading CSV file: \(error)")
            return []
        }
    }

    // Parser that respects quotes and commas within quotes
    private static func parseCSVRow(_ line: String) -> [String] {
        var fields: [String] = []
        var current = ""
        var inQuotes = false
        var iterator = line.makeIterator()

        while let ch = iterator.next() {
            if ch == "\"" {
                if inQuotes {
                    // Lookahead for escaped quote
                    if let next = iterator.next() {
                        if next == "\"" {
                            current.append("\"")
                        } else {
                            inQuotes = false
                            if next == "," {
                                fields.append(current)
                                current = ""
                            } else {
                                current.append(next)
                            }
                        }
                    } else {
                        inQuotes = false
                    }
                } else {
                    inQuotes = true
                }
            } else if ch == "," && !inQuotes {
                fields.append(current)
                current = ""
            } else {
                current.append(ch)
            }
        }

        fields.append(current)
        return fields.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
    }
}




