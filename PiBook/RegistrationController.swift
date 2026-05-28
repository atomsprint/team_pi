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
    @IBOutlet weak var gakunenButton: UIButton!

    @IBOutlet weak var gakunenLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!

    var selectedGenre: String = "未選択"
    var selectedGakunen: String = "未選択"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupGenreMenu()
        setupGakunenMenu()
        updateSelectedLabels()
    }

    private func setupUI() {
        summaryTextView.layer.borderWidth = 1.0
        summaryTextView.layer.borderColor = UIColor.systemGray4.cgColor
        summaryTextView.layer.cornerRadius = 5.0
    }

    private func updateSelectedLabels() {
        gakunenLabel.text = "学年：\(selectedGakunen)"
        genreLabel.text = "ジャンル：\(selectedGenre)"
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
                self?.updateSelectedLabels()
            }
        }

        genreButton.menu = UIMenu(title: "ジャンルを選択", children: actions)
        genreButton.showsMenuAsPrimaryAction = true
    }

    private func setupGakunenMenu() {
        let gakunens = ["低学年", "中学年", "高学年", "大人"]

        let actions = gakunens.map { title in
            UIAction(title: title) { [weak self] _ in
                self?.selectedGakunen = title
                self?.gakunenButton.setTitle(title, for: .normal)
                self?.updateSelectedLabels()
            }
        }

        gakunenButton.menu = UIMenu(title: "学年を選択", children: actions)
        gakunenButton.showsMenuAsPrimaryAction = true
    }

    @IBAction func selectImageButtonTapped(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        let title = titleTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let author = authorTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let publisher = publisherTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let pageCount = pageCountTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let summary = summaryTextView.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        if title.isEmpty || author.isEmpty || selectedGenre == "未選択" || selectedGakunen == "未選択" {
            let alert = UIAlertController(title: "入力エラー", message: "タイトル・著者・ジャンル・学年を入れてください", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }

        let fileManager = FileManager.default
        let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let csvURL = CSVLoader.workingCSVURL()

        if let image = bookImageView.image,
           let data = image.jpegData(compressionQuality: 0.8) {
            let imageURL = documentURL.appendingPathComponent("\(title).jpg")
            try? data.write(to: imageURL)
        }

        func csvText(_ text: String) -> String {
            let cleaned = text
                .replacingOccurrences(of: "\"", with: "\"\"")
                .replacingOccurrences(of: "\n", with: " ")
                .replacingOccurrences(of: "\r", with: " ")
            return "\"\(cleaned)\""
        }

        let csvArray = [
            csvText(title),
            csvText(""),
            csvText(author),
            csvText(publisher),
            csvText(""),
            csvText(selectedGakunen),
            csvText(""),
            csvText(""),
            csvText(pageCount),
            csvText(""),
            csvText(selectedGenre),
            csvText(""),
            csvText(""),
            csvText(""),
            csvText(summary),
            csvText(""),
            csvText("")
        ]

        let newLine = csvArray.joined(separator: ",") + "\n"

        var currentContent = ""

        if let oldContent = try? String(contentsOf: csvURL, encoding: .utf8) {
            currentContent = oldContent
        }

        if !currentContent.isEmpty && !currentContent.hasSuffix("\n") {
            currentContent += "\n"
        }

        currentContent += newLine

        do {
            try currentContent.write(to: csvURL, atomically: true, encoding: .utf8)
            print("登録成功：\(title)")
        } catch {
            print("CSV保存失敗：\(error)")
        }

        let successAlert = UIAlertController(title: "成功", message: "登録しました", preferredStyle: .alert)

        successAlert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            guard let self = self else { return }

            if let nav = self.navigationController {
                nav.popViewController(animated: true)
            } else {
                self.dismiss(animated: true)
            }
        })

        present(successAlert, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            bookImageView.image = image
        }

        dismiss(animated: true)
    }
}
