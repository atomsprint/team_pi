//
//  Book 2.swift
//  PiBook
//
//  Created by Kanta on 2026/04/05.
//


import Foundation

class Book {
    var title: String
    var author: String
    var publisher: String
    var pageCount: String
    var category1: String
    var category2: String
    var category3: String
    var category4: String
    var summary: String
    var gakunenn: String

    init(row: [String]) {
        self.title = row.count > 0 ? row[0] : "不明"
        self.author = row.count > 2 ? row[2] : "不明"
        self.publisher = row.count > 3 ? row[3] : "不明"
        self.gakunenn = row.count > 6 ? row[6].replacingOccurrences(of: "\"", with: "").trimmingCharacters(in: .whitespacesAndNewlines) : "高学年"
        
        var foundPage = "0"
        for item in row {
            let cleaned = item.trimmingCharacters(in: .whitespacesAndNewlines)
            if let pageNum = Int(cleaned), pageNum >= 10 && pageNum <= 999 {
                foundPage = cleaned
                break
            }
        }
        self.pageCount = foundPage
        
        self.category1 = row.count > 11 ? row[11].trimmingCharacters(in: .whitespacesAndNewlines) : ""
        self.category2 = row.count > 12 ? row[12].trimmingCharacters(in: .whitespacesAndNewlines) : ""
        self.category3 = row.count > 13 ? row[13].trimmingCharacters(in: .whitespacesAndNewlines) : ""
        self.category4 = row.count > 14 ? row[14].trimmingCharacters(in: .whitespacesAndNewlines) : ""
        
        var foundSummary = "あらすじなし"
        for item in row {
            let cleaned = item.trimmingCharacters(in: .whitespacesAndNewlines)
            if cleaned.count >= 30 {
                foundSummary = cleaned
                break
            }
        }
        self.summary = foundSummary
    }
}
