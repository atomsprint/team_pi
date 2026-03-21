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
    @IBOutlet weak var publisherLabel: UILabel?
    @IBOutlet weak var summaryLabel: UILabel? // 💡 接続が切れていないか確認！

    var book: Book?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let b = book {
            titleLabel?.text = "タイトル：\(b.title)"
            authorLabel?.text = "作者：\(b.author)"
            publisherLabel?.text = "出版社：\(b.publisher)"
            
            // 💡 あらすじを表示
            summaryLabel?.text = "あらすじ：\n\(b.summary)"
        }
    }
}
