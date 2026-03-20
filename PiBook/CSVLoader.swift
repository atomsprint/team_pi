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
        
        // 1. プロジェクト内の "books.csv" を探す
        guard let path = Bundle.main.path(forResource: "books", ofType: "csv") else {
            print("CSVが見つかりません")
            return books
        }
        
        do {
            let csvString = try String(contentsOfFile: path, encoding: .utf8)
            let lines = csvString.components(separatedBy: .newlines)
            
            for line in lines {
                if line.isEmpty { continue }
                
                // 2. カンマでデータを分ける
                let columns = line.components(separatedBy: ",")
                
                // 3. 安全にBookを作成（Bookクラスのinitにそのまま渡す）
                let book = Book(row: columns)
                books.append(book)
            }
        } catch {
            print("エラー: \(error)")
        }
        return books
    }
}
