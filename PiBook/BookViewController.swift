//
//  bookview.swift
//  PiBook
//
//  Created by Kanta on 2026/04/08.
//
import UIKit
import AudioToolbox

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

        let allBooks = CSVLoader.loadBooks()

        displayBooks = allBooks.filter { b in

            let isMatchGenre =
                b.category1 == selectedGenre ||
                b.category2 == selectedGenre ||
                b.category3 == selectedGenre ||
                b.category4 == selectedGenre

            let isNewBookNoGenre =
                b.category1 == "未選択" ||
                b.category1.isEmpty

            return isMatchGenre || isNewBookNoGenre
        }

        tableView.reloadData()
    }

    func gradeImageName(from gakunen: String) -> String? {

        if gakunen.contains("1") {
            return "grade1"
        } else if gakunen.contains("2") {
            return "grade2"
        } else if gakunen.contains("3") {
            return "grade3"
        } else if gakunen.contains("4") {
            return "grade4"
        } else if gakunen.contains("5") {
            return "grade5"
        } else if gakunen.contains("6") {
            return "grade6"
        }

        return nil
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayBooks.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        AudioServicesPlaySystemSound(1104)

        let generator = UIImpactFeedbackGenerator(style: .rigid)
        generator.impactOccurred()

        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")

        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        }

        let book = displayBooks[indexPath.row]

        let targetGakunen = book.gakunen

        var imageToDisplay: UIImage? = nil

        if let imageName = gradeImageName(from: targetGakunen) {
            imageToDisplay = UIImage(named: imageName)
        }

        if imageToDisplay == nil {
            imageToDisplay = UIImage(named: "book")
        }

        cell?.imageView?.image = imageToDisplay
        cell?.textLabel?.text = book.title
        cell?.detailTextLabel?.text = book.author

        return cell!
    }

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {

        performSegue(withIdentifier: "showDetail", sender: indexPath)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "showDetail" {

            if let detailVC = segue.destination as? BookListViewController,
               let indexPath = sender as? IndexPath {

                detailVC.book = displayBooks[indexPath.row]
            }
        }
    }
}
