//
//  BookListViewController.swift
//  PiBook
//
//  Created by Kanta on 2026/03/16.
//
import UIKit

class BookListViewController: UIViewController {

    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var pageCountLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!

    var book: Book?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let b = book else { return }

        pageCountLabel.text = "ページ数：\(b.pageCount)"
        summaryLabel.text = b.summary

        let imageName = b.title.trimmingCharacters(in: .whitespacesAndNewlines)

        if let image = UIImage(named: imageName) {
            bookImageView.image = image
        } else {
            bookImageView.image = UIImage(systemName: "book.closed")
    
        }

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toBookList",
           let nextVC = segue.destination as? BookListViewController {
            nextVC.book = self.book
        }
    }
}


