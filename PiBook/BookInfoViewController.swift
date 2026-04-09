//
//  BookInfoViewController.swift
//  PiBook
//
//  Created by Kanta on 2026/04/05.
//

//import UIKit

//class BookInfoViewController: UIViewController {
//
//    @IBOutlet weak var titleLabel: UILabel?
//    @IBOutlet weak var authorLabel: UILabel?
//    @IBOutlet weak var publisherLabel: UILabel?
//
//    var book: Book?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        if let b = book {
//            titleLabel?.text = "タイトル：\(b.title)"
//            authorLabel?.text = "作者：\(b.author)"
//            publisherLabel?.text = "出版社：\(b.publisher)"
//        }
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let detailVC = segue.destination as? BookListViewController {
//            detailVC.book = self.book
//        }
//    }
//}
import UIKit

class BookInfoViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!

    var book: Book?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let b = book else { return }

        titleLabel.text = "タイトル：\(b.title)"
        authorLabel.text = "作者：\(b.author)"
        publisherLabel.text = "出版社：\(b.publisher)"
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextVC = segue.destination as? BookListViewController {
            nextVC.book = book
        }
    }
}
