//
//  BookDetailViewController.swift
//  BookStore_JoaoGomes
//
//  Created by João Gomes on 30/11/2024.
//

import UIKit
import Kingfisher

class BookDetailViewController: ViewController
{
    //MARK: - Variables
    var book: Book!
    var thumbnailImage: UIImage?
    var hasZoomed: Bool = false
    var isFavourite: Bool = false
    {
        didSet
        {
            self.favouriteButton.isFavourited = self.isFavourite
        }
    }
    
    //MARK: - IBOutlets
    @IBOutlet weak var zoomHintText: UILabel!
    @IBOutlet weak var zoomHintView: UIView!
    @IBOutlet weak var favouriteButton: FavouriteButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorsLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var descriptionHeaderLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageScrollView: UIScrollView!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var purchaseButtonContainerView: UIView!
    @IBOutlet weak var purchaseButton: UIButton!
    
    //MARK: - Lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.imageScrollView.delegate = self
        
        self.isFavourite = CacheManager.shared.checkForBook(id: book.id)
        
        self.titleLabel.font = UIFont(name: "Lato-Black", size: 32)
        self.authorsLabel.font = UIFont(name: "Lato-Regular", size: 17)
        self.descriptionHeaderLabel.font = UIFont(name: "Lato-Bold", size: 17)
        self.yearLabel.font = UIFont(name: "Lato-Regular", size: 17)
        self.descriptionLabel.font = UIFont(name: "Lato-Regular", size: 17)
        self.zoomHintText.font = UIFont(name: "Lato-Bold", size: 24)
        if let title = book.volumeInfo.title
        {
            self.title = title
            self.titleLabel.text = title
        }
        
        if let authors = book.volumeInfo.authors
        {
            var authorText = ""
            for author in authors
            {
                authorText.append(", \(author)")
            }
            
            if let index = authorText.firstIndex(of: ",")
            {
                authorText.remove(at: index)
            }
            if let index = authorText.firstIndex(of: " ")
            {
                authorText.remove(at: index)
            }
            self.authorsLabel.text = authorText
        }
        
        if let year = book.volumeInfo.publishedDate
        {
            self.yearLabel.text = year
        }
        
        if let description = book.volumeInfo.description
        {
            self.descriptionLabel.text = description
        }
        
        self.purchaseButtonContainerView.isHidden = true
        if let _ = book.saleInfo.buyLink
        {
            self.purchaseButtonContainerView.isHidden = false
        }
        
        //Get image from cache if accessed from favourites
        if let thumbnail = self.thumbnailImage
        {
            self.bookImageView.image = thumbnail
        }
        else
        {
            //Get image from Kingfisher
            if let imageUrl = URL(string: book.volumeInfo.imageLinks?.thumbnail?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
            {
                self.bookImageView.kf.setImage(with: imageUrl, placeholder: nil ){ result in
                    switch result
                    {
                    case .success(_):
                        print("Photo Loaded")
                    case .failure(let error):
                        print("photo error: \(error.localizedDescription)")
                    }
                }
            }
        }

    }
    
    //MARK: - IBActions
    
    @IBAction func purchaseButtonPressed(_ sender: Any)
    {
        if let purchaseUrl = URL(string:book.saleInfo.buyLink ?? "")
        {
            UIApplication.shared.open(purchaseUrl)
        }
    }
    
    @IBAction func favouriteButtonPressed(_ sender: Any)
    {
        self.favouriteButton.isFavourited = !self.favouriteButton.isFavourited
        guard let book = self.book else
        {
            return
        }
        
        self.isFavourite = !self.isFavourite
        
        if isFavourite
        {
            CacheManager.shared.addBook(book, thumbnail: self.bookImageView.image)
        }
        else
        {
            CacheManager.shared.removeBook(id: book.id)
        }
    }
}

//MARK: - ScrollView Delegate
extension BookDetailViewController: UIScrollViewDelegate
{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return bookImageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if !hasZoomed
        {
            UIView.animate(withDuration: 0.5) {
                self.zoomHintView.alpha = 0
            }
        }
        
    }
}
