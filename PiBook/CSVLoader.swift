import Foundation

class CSVLoader {

    private static let workingCSVFileName = "books.csv"

    static func ensureWorkingCSVExists() {
        let fileManager = FileManager.default
        let destinationURL = workingCSVURL()

        let preloadURL1 = Bundle.main.url(
            forResource: "preload_books",
            withExtension: "csv",
            subdirectory: "data"
        )

        let preloadURL2 = Bundle.main.url(
            forResource: "preload_books",
            withExtension: "csv"
        )

        guard let preloadURL = preloadURL1 ?? preloadURL2 else {
            print("preload_books.csv が見つかりません")
            return
        }

        print("コピー元CSV：\(preloadURL.path)")
        print("コピー先CSV：\(destinationURL.path)")

        if fileManager.fileExists(atPath: destinationURL.path) {
            try? fileManager.removeItem(at: destinationURL)
        }

        do {
            try fileManager.copyItem(at: preloadURL, to: destinationURL)
            print("CSVコピー成功")
        } catch {
            print("CSVコピー失敗：\(error)")
        }
    }

    static func workingCSVURL() -> URL {
        let documentURL = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first!

        return documentURL.appendingPathComponent(workingCSVFileName)
    }

    static func loadBooks() -> [Book] {
        var books: [Book] = []

        ensureWorkingCSVExists()

        let csvURL = workingCSVURL()

        guard let csvString = try? String(contentsOf: csvURL, encoding: .utf8) else {
            print("CSVを読み込めません：\(csvURL.path)")
            return books
        }

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

        print("読み込んだ本の数：\(books.count)")
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
