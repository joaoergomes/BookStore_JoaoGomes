//
//  ListViewController.swift
//  BookStore_JoaoGomes
//
//  Created by João Gomes on 27/11/2024.
//

import UIKit

class ListViewController: UIViewController
{
    var books: [Book] = []
    {
        didSet
        {
            self.collectionView.reloadData()
        }
    }
    
    //MARK: - IBOutlets
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = ""
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        //Favourites List
        let favouriteButtonItem = UIBarButtonItem(image: UIImage(named: "archive"), style: .plain, target: self, action: #selector(goToFavourites))
        self.navigationItem.rightBarButtonItem = favouriteButtonItem
        
        performLoad()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        if !books.isEmpty
        {
            self.collectionView.reloadData()
        }
           
    }
    
    override func viewWillLayoutSubviews()
    {
        super.viewWillLayoutSubviews()
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    private func performLoad()
    {
        self.activityIndicatorView.startAnimating()
        NetworkManager.shared.loadBookItems(index: books.count, numResults: 20) { [weak self] result in
            DispatchQueue.main.async
            {
                switch result
                {
                case .success(let data):
                    self?.activityIndicatorView.stopAnimating()
                    self?.books.append(contentsOf: data.items)
                case .failure(let error):
                    print("error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    @objc func goToFavourites()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "FavouritesViewController") as? FavouritesViewController
        {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

//MARK: - UICollectionViewDataSource
extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCell", for: indexPath) as! BookCell
        cell.isFavourite = CacheManager.shared.checkForBook(id: books[indexPath.row].id)
        cell.configure(for: books[indexPath.row])
        cell.favouriteAction = {book in CacheManager.shared.addBook(book.book, thumbnail: book.thumbnailBase64?.imageFromBase64)}
        cell.unfavouriteAction = {book in CacheManager.shared.removeBook(id: book.id)}
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if(indexPath.row == books.count - 4)
        {
            performLoad()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "BookDetailViewController") as? BookDetailViewController
        {
            vc.book = books[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}

extension ListViewController: UICollectionViewDelegateFlowLayout
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

