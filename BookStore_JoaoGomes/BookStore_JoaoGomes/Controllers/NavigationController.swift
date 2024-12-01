//
//  NavigationController.swift
//  BookStore_JoaoGomes
//
//  Created by João Gomes on 01/12/2024.
//

import UIKit

class NavigationController: UINavigationController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.customizeNavigationBar()
    }
    
    private func customizeNavigationBar()
    {
        //Tint Color
        self.navigationBar.tintColor = .black
        
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont(name: "Lato-Bold", size: 17)!
        ]
        UINavigationBar.appearance().titleTextAttributes = attrs
        
        
    }
}
