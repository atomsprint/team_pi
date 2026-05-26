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
        if !targetGakunen.isEmpty {
            imageToDisplay = UIImage(named: targetGakunen)
        }
        
        if imageToDisplay == nil {
            imageToDisplay = UIImage(named: "book")
        }
        
        if cell?.imageView?.superview != nil {
            cell?.imageView?.image = imageToDisplay
        } else {
            let forcedImageView = UIImageView(image: imageToDisplay)
            forcedImageView.contentMode = .scaleAspectFit
            forcedImageView.frame = CGRect(x: 10, y: 5, width: 40, height: 40)
            cell?.contentView.addSubview(forcedImageView)
        }
        
        cell?.textLabel?.text = book.author
        cell?.detailTextLabel?.text = book.title
        return cell!
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
