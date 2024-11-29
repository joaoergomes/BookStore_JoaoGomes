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
       
        manager.loadBookItems(index: 0, numResults: 20) { result in
            switch result
            {
            case .success(let data):
                print("success")
            case .failure(let error):
                print("error")
            }
        }
        
    }


}

