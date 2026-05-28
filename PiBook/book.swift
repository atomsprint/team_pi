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
    var gakunen: String

    init(row: [String]) {
        self.title = row.count > 0 ? Self.clean(row[0]) : "不明"
        self.author = row.count > 2 ? Self.clean(row[2]) : "不明"
        self.publisher = row.count > 3 ? Self.clean(row[3]) : "不明"
        self.gakunen = row.count > 5 ? Self.clean(row[5]) : "高学年"

        if row.count > 8 {
            self.pageCount = Self.extractPageCount(from: row[8])
        } else {
            self.pageCount = "0"
        }

        self.category1 = row.count > 10 ? Self.clean(row[10]) : ""
        self.category2 = row.count > 11 ? Self.clean(row[11]) : ""
        self.category3 = row.count > 12 ? Self.clean(row[12]) : ""
        self.category4 = row.count > 13 ? Self.clean(row[13]) : ""

        if row.count > 14 {
            let summaryText = Self.clean(row[14])
            self.summary = summaryText.isEmpty ? "あらすじなし" : summaryText
        } else {
            self.summary = "あらすじなし"
        }
    }

    private static func clean(_ text: String) -> String {
        return text
            .replacingOccurrences(of: "\"", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private static func extractPageCount(from text: String) -> String {
        let cleaned = Self.clean(text)
            .replacingOccurrences(of: "ページ", with: "")
            .replacingOccurrences(of: "P", with: "")
            .replacingOccurrences(of: "p", with: "")

        let converted = cleaned.applyingTransform(.fullwidthToHalfwidth, reverse: false) ?? cleaned
        let digits = converted.filter { $0.isNumber }

        if digits.isEmpty {
            return "0"
        }

        return String(digits)
    }
}
