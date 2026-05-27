//
//  BookListViewController.swift
//  PiBook
//
//  Created by Kanta on 2026/03/16.
//
import SwiftUI
import AudioToolbox // 💡 4桁の音を鳴らすために必須

struct ContentView: View {
    var body: some View {
        VStack {
            Button(action: {

                AudioServicesPlaySystemSound(1104)
                

    
                let generator = UIImpactFeedbackGenerator(style: .heavy)
                generator.impactOccurred()
            }) {
                Text("ボタンを押す")
                    .font(.headline)
                    .padding()
                    .frame(width: 200, height: 50)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
  
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


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
   

        AudioServicesPlaySystemSound(1104)
            

        let generator = UIImpactFeedbackGenerator(style: .rigid)
        generator.impactOccurred()
        

        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func backToHomeButtonTapped(_ sender: Any) {
        AudioServicesPlaySystemSound(1104)
            
  
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        if let nav = self.navigationController {
            let stack = nav.viewControllers
            if stack.count >= 2 {
                nav.popToViewController(stack[1], animated: true)
            } else {
                nav.popToRootViewController(animated: true)
            }
        } else {
            var top = self.presentingViewController
            while let parent = top?.presentingViewController {
                if parent.presentingViewController == nil { break }
                top = parent
            }
            top?.dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func deleteBookButtonTapped(_ sender: Any) {
        AudioServicesPlaySystemSound(1104)
            
  
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        guard let targetTitle = book?.title else { return }
        let fileManager = FileManager.default
        let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let csvURL = CSVLoader.workingCSVURL()
        
        if let csvString = try? String(contentsOf: csvURL, encoding: .utf8) {
            let lines = csvString.components(separatedBy: .newlines)
            let filteredLines = lines.filter { line in
                let trimmed = line.trimmingCharacters(in: .whitespacesAndNewlines)
                guard !trimmed.isEmpty else { return false }
                let columns = CSVLoader.parseCSVLine(trimmed)
                return columns.first?.trimmingCharacters(in: .whitespacesAndNewlines) != targetTitle
            }
            let newContent = filteredLines.joined(separator: "\n") + "\n"
            try? newContent.write(to: csvURL, atomically: true, encoding: .utf8)
        }
        
        let imageURL = documentURL.appendingPathComponent("\(targetTitle).jpg")
        try? fileManager.removeItem(at: imageURL)
        
        let alert = UIAlertController(title: "削除", message: "本を削除しました", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            if let nav = self.navigationController {
                nav.popViewController(animated: true)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        })
        present(alert, animated: true)
    }

    private func setupUI() {
        guard let b = book else { return }
        titleLabel.text = "タイトル：\(b.title)"
        authorLabel.text = "著者：\(b.author)"
        publisherLabel.text = "出版社：\(b.publisher)"
        pageCountLabel.text = "ページ数：\(b.pageCount)"
        summaryLabel.text = b.summary
        
        let imageName = b.title.trimmingCharacters(in: .whitespacesAndNewlines)
        let fileManager = FileManager.default
        let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentURL.appendingPathComponent("\(imageName).jpg")
        
        if fileManager.fileExists(atPath: fileURL.path) {
            bookImageView.image = UIImage(contentsOfFile: fileURL.path)
        } else if let assetImage = UIImage(named: imageName) {
            bookImageView.image = assetImage
        } else {
            bookImageView.image = UIImage(systemName: "book.closed")
        }
    }
}
import UIKit
import AudioToolbox


class SoundButton: UIButton {


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSoundAction()
    }


    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSoundAction()
    }


    private func setupSoundAction() {

        self.addTarget(self, action: #selector(playSoundAndVibe), for: .touchDown)
    }


    @objc private func playSoundAndVibe() {

        AudioServicesPlaySystemSound(1104)
        

        let generator = UIImpactFeedbackGenerator(style: .rigid)
        generator.impactOccurred()
    }
}
