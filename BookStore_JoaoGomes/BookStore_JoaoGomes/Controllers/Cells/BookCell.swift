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
    private var book: Book? = nil
    var isFavourite: Bool = false
    {
        didSet
        {
            self.favouriteButton.isFavourited = isFavourite
        }
    }
    
    var favouriteAction: ((BookWithThumbnailData) -> (Void))? = nil
    var unfavouriteAction: ((Book) -> Void)? = nil
    
    var imageIsLoaded: Bool = false
    
    @IBOutlet weak var favouriteButton: FavouriteButton!
    @IBOutlet weak var cellContainerView: UIView!
    @IBOutlet weak var infoContainerView: UIView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    func configure(for bookWithThumbnail: BookWithThumbnailData)
    {
        self.book = bookWithThumbnail.book
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 4
        self.clipsToBounds = false
        self.cellContainerView.clipsToBounds = true
        self.cellContainerView.layer.cornerRadius = 5
        
        self.favouriteButton.layer.cornerRadius = self.favouriteButton.frame.height / 2
        self.favouriteButton.layer.shadowColor = UIColor.black.cgColor
        self.favouriteButton.layer.shadowOpacity = 0.3
        self.favouriteButton.layer.shadowRadius = 4
        
        self.titleLabel.text = bookWithThumbnail.book.volumeInfo.title
        self.authorLabel.text = bookWithThumbnail.book.volumeInfo.authors?.first
        if let authors = bookWithThumbnail.book.volumeInfo.authors, authors.count > 1
        {
            self.authorLabel.text = authors.first?.appending("list_more_authors".i18n ?? "")
        }
       
        self.yearLabel.text = bookWithThumbnail.book.volumeInfo.publishedDate
        
        self.imageView.image = bookWithThumbnail.thumbnailBase64?.imageFromBase64
    }
    
    
    func configure(for book: Book)
    {
        self.book = book
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 4
        self.clipsToBounds = false
        self.cellContainerView.clipsToBounds = true
        self.cellContainerView.layer.cornerRadius = 5
        
        self.favouriteButton.layer.cornerRadius = self.favouriteButton.frame.height / 2
        self.favouriteButton.layer.shadowColor = UIColor.black.cgColor
        self.favouriteButton.layer.shadowOpacity = 0.3
        self.favouriteButton.layer.shadowRadius = 4
        
        self.titleLabel.text = book.volumeInfo.title
        self.authorLabel.text = book.volumeInfo.authors?.first
        if let authors = book.volumeInfo.authors, authors.count > 1
        {
            self.authorLabel.text = authors.first?.appending("list_more_authors".i18n ?? "")
        }
       
        self.yearLabel.text = book.volumeInfo.publishedDate
        
        
        if let imageUrl = URL(string: book.volumeInfo.imageLinks?.thumbnail?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        {
            self.imageView.kf.setImage(with: imageUrl, placeholder: nil ){ result in
                switch result
                {
                case .success(_):
                    self.imageIsLoaded = true
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    @IBAction func favouriteButtonPressed(_ sender: Any)
    {
        guard let book = self.book else
        {
            return
        }
        
        self.isFavourite = !self.isFavourite
        
        if isFavourite
        {
            favouriteAction?(BookWithThumbnailData(book: book,
                                                   thumbnailBase64: imageIsLoaded ? self.imageView.image?.base64 : nil))
        }
        else
        {
            unfavouriteAction?(book)
        }
    }
    
}
