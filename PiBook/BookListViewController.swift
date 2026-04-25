//
//  BookListViewController.swift
//  PiBook
//
//  Created by Kanta on 2026/03/16.
//
import UIKit

class BookListViewController: UIViewController {

    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var pageCountLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!

    var book: Book?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    @IBAction func backToListButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func backToHomeButtonTapped(_ sender: Any) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }

    private func setupUI() {
        guard let b = book else { return }
        
        titleLabel.text = "タイトル：\(b.title)"
        authorLabel.text = "著者：\(b.author)"
        publisherLabel.text = "出版社：\(b.publisher)"
        pageCountLabel.text = "ページ数：\(b.pageCount)"
        summaryLabel.text = b.summary
        
        let imageName = b.title.trimmingCharacters(in: .whitespacesAndNewlines)
        if let image = UIImage(named: imageName) {
            bookImageView.image = image
        } else {
            bookImageView.image = UIImage(systemName: "book.closed")
        }
    }
}
