//
//  BookCell.swift
//  BookStore_JoaoGomes
//
//  Created by João Gomes on 29/11/2024.
//

import UIKit
import Kingfisher

class BookCell: UICollectionViewCell
{
    
    @IBOutlet weak var infoContainerView: UIView!
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
        
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = infoContainerView.frame
        self.infoContainerView.layer.insertSublayer(gradientLayer, at: 0)
        
        
        if let imageUrl = URL(string: book.volumeInfo.imageLinks?.thumbnail?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        {
            self.imageView.kf.setImage(with: imageUrl, placeholder: nil ){ result in
                switch result
                {
                case .success(let result):
                    print("photo success")
                case .failure(let error):
                    print("photo error: \(error.localizedDescription)")
                }
            }
        }
        
        
    }
}
