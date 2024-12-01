//
//  ViewController.swift
//  BookStore_JoaoGomes
//
//  Created by João Gomes on 01/12/2024.
//

import UIKit

class ViewController: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func presentAlert(with title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "alert_close".i18n, style: .default))
        
        self.present(alert, animated: true)
    }
    
    
}
