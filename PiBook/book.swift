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
    
    init(row: [String]) {
        // 1列目（0番目）はタイトル
        self.title = row.count > 0 ? row[0] : "タイトル不明"
        
        // 💡 ここを逆にします！
        // もし今まで author = row[1] だったら、row[2] に変えます。
        // （画像から推測すると、3列目[2]が作者で、2列目[1]が出版社ですね）
        
        if row.count > 2 {
            self.author = row[2]     // 3列目を作者にする
            self.publisher = row[1]  // 2列目を出版社にする
        } else if row.count > 1 {
            self.author = row[1]
            self.publisher = "不明"
        } else {
            self.author = "不明"
            self.publisher = "不明"
        }
    }
}
