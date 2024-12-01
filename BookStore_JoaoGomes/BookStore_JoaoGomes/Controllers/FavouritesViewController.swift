//
//  FavouritesViewController.swift
//  BookStore_JoaoGomes
//
//  Created by João Gomes on 01/12/2024.
//

import UIKit

class FavouritesViewController: UIViewController
{
    
    //MARK: - Variables
    var books: [BookWithThumbnailData] = []
    {
        didSet
        {
            self.emptyListLabel.isHidden = !books.isEmpty
            self.collectionView.reloadData()
        }
    }
    
    private var isReturningFromDetailScreen: Bool = false
    
    //MARK: - IBOutlets
    @IBOutlet weak var emptyListLabel: LocalizedLabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Lifecycle
    override func viewDidLoad()
    {

        super.viewDidLoad()
        self.title = "favourites_screen_title".i18n
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.activityIndicatorView.isHidden = true
        
        self.emptyListLabel.isHidden = true
        
        performLoad()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        if self.isReturningFromDetailScreen
        {
            performLoad()
            self.isReturningFromDetailScreen = false
        }
        
    }
    
    override func viewWillLayoutSubviews()
    {
        super.viewWillLayoutSubviews()
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    private func performLoad()
    {
        self.books = CacheManager.shared.getAllBooks()
    }
    
}

//MARK: - UICollectionViewDataSource
extension FavouritesViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCell", for: indexPath) as! BookCell
        cell.isFavourite = true
        cell.configure(for: books[indexPath.row])
        cell.favouriteAction = {book in CacheManager.shared.addBook(book.book, thumbnail: book.thumbnailBase64?.imageFromBase64)}
        cell.unfavouriteAction = {[weak self] book in
            CacheManager.shared.removeBook(id: book.id)
            self?.performLoad()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "BookDetailViewController") as? BookDetailViewController
        {
            vc.book = books[indexPath.row].book
            vc.thumbnailImage = books[indexPath.row].thumbnailBase64?.imageFromBase64
            self.isReturningFromDetailScreen = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}

extension FavouritesViewController: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        self.collectionView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        let columns: CGFloat = 2
        let height: CGFloat = 300
        let interval:CGFloat = 16
        
        let intervalSum: CGFloat = interval * (columns - 1)
        return CGSize(width: (collectionView.frame.width - intervalSum - 16)/columns, height: height)
    }
}


