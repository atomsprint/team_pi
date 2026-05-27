//
//  CSVLoader.swift
//  PiBook
//
//  Created by Kanta on 2026/03/16.
//

import Foundation

class CSVLoader {
    
    private static let workingCSVFileName = "books.csv"
    private static let preloadCSVName = "preload_books"
    private static let preloadCSVExtension = "csv"
    private static let preloadCSVSubdirectory = "data"
    
    static func ensureWorkingCSVExists() {
        let fileManager = FileManager.default
        let destinationURL = workingCSVURL()
        
        guard !fileManager.fileExists(atPath: destinationURL.path) else {
            return
        }
        
        guard
            let preloadPath = Bundle.main.path(
                forResource: preloadCSVName,
                ofType: preloadCSVExtension,
                inDirectory: preloadCSVSubdirectory
            )
        else {
            print("Preload CSV not found in bundle.")
            return
        }
        
        do {
            try fileManager.copyItem(atPath: preloadPath, toPath: destinationURL.path)
        } catch {
            print("Failed to copy preload CSV: \(error)")
        }
    }
    
    static func workingCSVURL() -> URL {
        let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentURL.appendingPathComponent(workingCSVFileName)
    }
    
    static func loadBooks() -> [Book] {
        var books = [Book]()
        var csvString = ""
        
        ensureWorkingCSVExists()
        
        let csvURL = workingCSVURL()
        do {
            csvString = try String(contentsOf: csvURL, encoding: .utf8)
        } catch {
            print("CSV Error: \(error)")
            return books
        }
        
        let lines = csvString.components(separatedBy: .newlines)
        
        for line in lines {
            if line.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                continue
            }
            
            let columns = parseCSVLine(line)
            
            if columns.count >= 7 {
                books.append(Book(row: columns))
            }
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
