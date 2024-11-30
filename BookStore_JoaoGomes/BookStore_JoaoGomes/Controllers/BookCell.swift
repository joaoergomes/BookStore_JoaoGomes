//
//  BookCell.swift
//  BookStore_JoaoGomes
//
//  Created by João Gomes on 29/11/2024.
//

import UIKit

class BookCell: UICollectionViewCell
{
    
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    func configure(for book: Book)
    {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 4
        self.clipsToBounds = false
        self.layer.cornerRadius = 5
        
        self.titleLabel.text = book.volumeInfo.title
        self.authorLabel.text = book.volumeInfo.authors?.first
        self.yearLabel.text = book.volumeInfo.publishedDate
    }
}
