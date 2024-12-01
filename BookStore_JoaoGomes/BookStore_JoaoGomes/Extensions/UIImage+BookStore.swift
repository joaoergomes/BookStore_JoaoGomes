//
//  UIImage+BookStore.swift
//  BookStore_JoaoGomes
//
//  Created by João Gomes on 30/11/2024.
//

import UIKit

extension UIImage
{
    var base64: String?
    {
        self.jpegData(compressionQuality: 1)?.base64EncodedString()
    }
}
