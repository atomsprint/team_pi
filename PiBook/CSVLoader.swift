import Foundation

class CSVLoader {

    private static let userCSVFileName = "user_books.csv"

    static func ensureWorkingCSVExists() {
    }

    static func workingCSVURL() -> URL {
        let documentURL = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first!

        return documentURL.appendingPathComponent(userCSVFileName)
    }

    static func loadBooks() -> [Book] {
        var books: [Book] = []

        let preloadURL1 = Bundle.main.url(
            forResource: "preload_books",
            withExtension: "csv",
            subdirectory: "data"
        )

        let preloadURL2 = Bundle.main.url(
            forResource: "preload_books",
            withExtension: "csv"
        )

        if let preloadURL = preloadURL1 ?? preloadURL2,
           let preloadString = try? String(contentsOf: preloadURL, encoding: .utf8) {

            books += booksFromCSVString(preloadString)
        }

        let userURL = workingCSVURL()

        if let userString = try? String(contentsOf: userURL, encoding: .utf8) {
            books += booksFromCSVString(userString)
        }

        print("読み込んだ本の数：\(books.count)")
        return books
    }

    private static func booksFromCSVString(_ csvString: String) -> [Book] {
        var books: [Book] = []

        let lines = csvString.components(separatedBy: .newlines)

        for line in lines {
            let trimmed = line.trimmingCharacters(in: .whitespacesAndNewlines)

            if trimmed.isEmpty {
                continue
            }

            let columns = parseCSVLine(trimmed)

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
