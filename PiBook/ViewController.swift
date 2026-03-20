//
//  ViewController.swift
//  PiBook
//
//  Created by Kanta atoms　hokkaidou on 2025/11/14.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var displayBooks = CSVLoader.load()

    override func viewDidLoad() {
        super.viewDidLoad()
        // 💡 タップを検知するために必要です
        tableView?.dataSource = self
        tableView?.delegate = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayBooks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let book = displayBooks[indexPath.row]
        cell.textLabel?.text = book.title
        cell.detailTextLabel?.text = "作者：\(book.author)"
        return cell
    }

    // タップされた時の動作
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetail", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let selectedBook = displayBooks[indexPath.row]
                if let detailVC = segue.destination as? BookListViewController {
                    detailVC.book = selectedBook
                }
            }
        }
    }
}
