//
//  CSVLoader.swift
//  PiBook
//
//  Created by Kanta on 2026/03/16.
//

import Foundation

class CSVLoader {
    
    static func load() -> [Book] {
        var books = [Book]()
        let fileName = "books.csv"
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        guard let documentURL = urls.first else { return books }
        let fileURL = documentURL.appendingPathComponent(fileName)
        
        var csvString = ""
        
        do {
            if fileManager.fileExists(atPath: fileURL.path) {
                csvString = try String(contentsOf: fileURL, encoding: .utf8)
            } else if let bundlePath = Bundle.main.path(forResource: "books", ofType: "csv") {
                csvString = try String(contentsOfFile: bundlePath, encoding: .utf8)
            } else {
                return books
            }
            
            let lines = csvString.components(separatedBy: .newlines)
            
            for line in lines {
                if line.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    continue
                }
                
                let columns = parseCSVLine(line)
                
                if columns.count >= 15 {
                    books.append(Book(row: columns))
                }
            }
            
        } catch {
            print("CSV Error: \(error)")
        }
        
        return books
    }
    
    static func parseCSVLine(_ line: String) -> [String] {
        var result: [String] = []
        var current = ""
        var insideQuotes = false
        for char in line {
            if char == "\"" {
                insideQuotes.toggle()
            } else if char == "," && !insideQuotes {
                result.append(current.trimmingCharacters(in: .whitespacesAndNewlines))
                current = ""
            } else {
                current.append(char)
            }
        }
        result.append(current.trimmingCharacters(in: .whitespacesAndNewlines))
        return result
    }
}
