//
//  RegistrationController.swift
//  PiBook
//
//  Created by Kanta on 2026/04/29.
//

import UIKit

class RegistrationViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var publisherTextField: UITextField!
    @IBOutlet weak var pageCountTextField: UITextField!
    @IBOutlet weak var genreButton: UIButton!
    @IBOutlet weak var summaryTextView: UITextView!
    @IBOutlet weak var bookImageView: UIImageView!

    var selectedGenre: String = "未選択"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupGenreMenu()
    }

    private func setupUI() {
        summaryTextView.layer.borderWidth = 1.0
        summaryTextView.layer.borderColor = UIColor.systemGray4.cgColor
        summaryTextView.layer.cornerRadius = 5.0
    }

    private func setupGenreMenu() {
        let genres = [
            "ユーモアの扉", "冒険の扉", "ファンタジーの扉", "ミステリーの扉",
            "恐怖の扉", "学校の扉", "文学の扉", "算数の扉", "家族の扉",
            "動物・植物の扉", "神話の扉", "知識の扉", "伝記・歴史の扉",
            "スポーツの扉", "友達の扉", "その他"
        ]
        let actions = genres.map { title in
            UIAction(title: title) { [weak self] _ in
                self?.selectedGenre = title
                self?.genreButton.setTitle(title, for: .normal)
            }
        }
        genreButton.menu = UIMenu(title: "ジャンルを選択", children: actions)
        genreButton.showsMenuAsPrimaryAction = true
    }

    @IBAction func selectImageButtonTapped(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        let title = titleTextField.text ?? ""
        let author = authorTextField.text ?? ""
        let publisher = publisherTextField.text ?? ""
        let pageCount = pageCountTextField.text ?? ""
        let summary = summaryTextView.text ?? ""
        
        if title.isEmpty || author.isEmpty || selectedGenre == "未選択" {
            let alert = UIAlertController(title: "入力エラー", message: "未入力の項目があります", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }

        let fileManager = FileManager.default
        let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!

        if let image = bookImageView.image, let data = image.jpegData(compressionQuality: 0.8) {
            let imageURL = documentURL.appendingPathComponent("\(title).jpg")
            try? data.write(to: imageURL)
        }
        
        let csvArray = [
            title, "", author, publisher, "", "", "", "", pageCount, "",
            selectedGenre, "", "", "", summary
        ]
        let newLine = csvArray.joined(separator: ",") + "\n"
        
        let fileURL = documentURL.appendingPathComponent("books.csv")
        
        if !fileManager.fileExists(atPath: fileURL.path) {
            if let bundlePath = Bundle.main.path(forResource: "books", ofType: "csv") {
                try? fileManager.copyItem(atPath: bundlePath, toPath: fileURL.path)
            }
        }
        
        if let fileHandle = try? FileHandle(forWritingTo: fileURL) {
            fileHandle.seekToEndOfFile()
            fileHandle.write(newLine.data(using: .utf8)!)
            fileHandle.closeFile()
        } else {
            try? newLine.write(to: fileURL, atomically: true, encoding: .utf8)
        }
        
        let successAlert = UIAlertController(title: "成功", message: "登録しました", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            guard let self = self else { return }
            if let nav = self.navigationController {
                nav.popViewController(animated: true)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
        successAlert.addAction(okAction)
        present(successAlert, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            bookImageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}
