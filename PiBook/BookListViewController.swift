//
//  BookListViewController.swift
//  PiBook
//
//  Created by Kanta on 2026/03/16.
//
import UIKit

class BookListViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var authorLabel: UILabel?
    @IBOutlet weak var publisherLabel: UILabel? // 💡 出版社ラベルを追加

    var book: Book?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let b = book {
            titleLabel?.text = "タイトル：\(b.title)"
            authorLabel?.text = "作者：\(b.author)"
            publisherLabel?.text = "出版社：\(b.publisher)" // 💡 表示させる
        }
    }
}
