//
//  ViewController.swift
//  BookStore_JoaoGomes
//
//  Created by João Gomes on 27/11/2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let manager = NetworkManager()
        manager.loadBooks()
    }


}

