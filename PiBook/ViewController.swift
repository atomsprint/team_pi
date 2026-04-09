//
//  ViewController.swift
//  PiBook
//
//  Created by Kanta atoms　hokkaidou on 2025/11/14.
//
import UIKit

class ViewController: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? BookViewController else { return }

        switch segue.identifier {
        case "算数の扉":
            vc.selectedGenre = "算数の扉"
        case "スポーツの扉":
            vc.selectedGenre = "スポーツの扉"
        case "友達の扉":
            vc.selectedGenre = "友達の扉"
        case "冒険の扉":
            vc.selectedGenre = "冒険の扉"
        case "ミステリーの扉":
            vc.selectedGenre = "ミステリーの扉"
        case "文学の扉":
            vc.selectedGenre = "文学の扉"
        case "伝記・歴史の扉":
            vc.selectedGenre = "伝記・歴史の扉"
        case "知識の扉":
            vc.selectedGenre = "知識の扉"
        case "学校の扉":
            vc.selectedGenre = "学校の扉"
        case "ユーモアの扉":
            vc.selectedGenre = "ユーモアの扉"
        case "不思議の扉":
            vc.selectedGenre = "不思議の扉"
        case "神話・昔話の扉":
            vc.selectedGenre = "神話・昔話の扉"
        case "動物・昆虫の扉":
            vc.selectedGenre = "動物・昆虫の扉"
        case "家族の扉":
            vc.selectedGenre = "家族の扉"
        case "恐怖の扉":
            vc.selectedGenre = "恐怖の扉"
        case "ファンタジーの扉":
            vc.selectedGenre = "ファンタジーの扉"
        default:
            vc.selectedGenre = ""
        }

        print("segue.identifier = \(segue.identifier ?? "nil")")
        print("渡す selectedGenre = \(vc.selectedGenre)")
    }
}


