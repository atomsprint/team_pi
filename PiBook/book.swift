//
//  File.swift
//  PiBook
//
//  Created by Kanta on 2026/03/16.
//
import Foundation

class Book {
    var title: String
    var author: String
    var publisher: String
    var summary: String
    
    init(row: [String]) {
        // 1. 基本データを取り出す（[数字] を忘れずに！）
        self.title = row.count > 0 ? row[0] : "不明"
        self.publisher = row.count > 1 ? row[1] : "不明"
        self.author = row.count > 2 ? row[2] : "不明"
        
        // 2. 💡【最後から3番目を狙い撃ち】
        // row.count - 3 が「最後から3番目」の場所です
        if row.count >= 3 {
            let index = row.count - 3
            let candidate = row[index]
            
            // もしそこが空っぽなら、一番長い文章を自動で探す
            if candidate.count > 5 {
                self.summary = candidate
            } else {
                // バックアップ：一番文字数が多い場所を探す
                self.summary = row.max(by: { $0.count < $1.count }) ?? "あらすじなし"
            }
        } else {
            self.summary = "あらすじデータがありません"
        }
    }
}
