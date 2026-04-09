//
//  Page2ViewController.swift
//  PiBook
//
//  Created by Kanta on 2025/11/30.
//

import UIKit

class Page2ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextVC = segue.destination as? BookViewController {

            nextVC.selectedGenre = segue.identifier ?? ""
        }
    }
}
