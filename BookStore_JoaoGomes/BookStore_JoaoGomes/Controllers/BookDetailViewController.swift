//
//  BookDetailViewController.swift
//  BookStore_JoaoGomes
//
//  Created by João Gomes on 30/11/2024.
//

import UIKit

class BookDetailViewController: UIViewController
{
    //MARK: - Variables
    var book: Book!
    
    //MARK: - IBOutlets
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
        if let title = book.volumeInfo.title
        {
            self.title = title
            self.titleLabel.text = title
        }
        
        if let authors = book.volumeInfo.authors
        {
            self.authorsLabel.text = ""
            for author in authors
            {
                self.authorsLabel.text?.append(author)
            }
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
        if let purchaseUrl = book.saleInfo.buyLink
        {
            self.purchaseButtonContainerView.isHidden = false
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
    
}


extension BookDetailViewController: UIScrollViewDelegate
{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return bookImageView
    }
}
