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

    init(row: [String]) {
        self.title = row.count > 0 ? row[0] : "不明"
        self.author = row.count > 2 ? row[2] : "不明"
        self.publisher = row.count > 3 ? row[3] : "不明"
        self.pageCount = row.count > 8 ? row[8] : "0"
        
        self.category1 = row.count > 10 ? row[10].trimmingCharacters(in: .whitespacesAndNewlines) : ""
        self.category2 = row.count > 11 ? row[11].trimmingCharacters(in: .whitespacesAndNewlines) : ""
        self.category3 = row.count > 12 ? row[12].trimmingCharacters(in: .whitespacesAndNewlines) : ""
        self.category4 = row.count > 13 ? row[13].trimmingCharacters(in: .whitespacesAndNewlines) : ""
        
        self.summary = row.count > 14 ? row[14] : "あらすじなし"
    }
}
