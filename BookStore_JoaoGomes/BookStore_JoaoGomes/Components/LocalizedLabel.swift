//
//  LocalizedLabel.swift
//  BookStore_JoaoGomes
//
//  Created by João Gomes on 30/11/2024.
//

import UIKit

@IBDesignable class LocalizedLabel: UILabel
{
    @IBInspectable var localizedText: String?
    {
        didSet
        {
            if let localizedText = localizedText
            {
                self.text = localizedText.i18n
            }
            
        }
    }
}
