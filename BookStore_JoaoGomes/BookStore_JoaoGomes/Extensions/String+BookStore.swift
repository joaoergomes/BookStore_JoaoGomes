//
//  String+BookStore.swift
//  BookStore_JoaoGomes
//
//  Created by João Gomes on 30/11/2024.
//
import UIKit

extension String
{
    var imageFromBase64: UIImage?
    {
        guard let imageData = Data(base64Encoded: self, options: .ignoreUnknownCharacters) else
        {
            return nil
        }
        return UIImage(data: imageData)
    }
    
    var i18n: String?
    {
        return NSLocalizedString(self, comment: "")
    }
}
