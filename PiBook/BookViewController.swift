//
//  bookview.swift
//  PiBook
//
//  Created by Kanta on 2026/04/08.
//
import UIKit

class BookViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    var selectedGenre: String = ""
    var displayBooks: [Book] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadAndFilterBooks()
    }

    private func loadAndFilterBooks() {
        let allBooks = CSVLoader.load()
        displayBooks = allBooks.filter { b in
            b.category1 == selectedGenre ||
            b.category2 == selectedGenre ||
            b.category3 == selectedGenre ||
            b.category4 == selectedGenre
        }
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayBooks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let book = displayBooks[indexPath.row]
        cell.textLabel?.text = book.author
        cell.detailTextLabel?.text = book.title
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toBookList", sender: indexPath)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toBookList",
           let infoVC = segue.destination as? BookListViewController,
           let indexPath = sender as? IndexPath {
            infoVC.book = displayBooks[indexPath.row]
        }
    }
}
