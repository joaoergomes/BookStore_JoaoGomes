//
//  ViewController.swift
//  BookStore_JoaoGomes
//
//  Created by João Gomes on 27/11/2024.
//

import UIKit

class ListViewController: UIViewController
{
    //MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ""
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        //self.collectionView.register(BookCell.self, forCellWithReuseIdentifier: "BookCell")
        // Do any additional setup after loading the view.
        
        //        let manager = NetworkManager()
        
        //        manager.loadBookItems(index: 0, numResults: 20) { result in
        //            switch result
        //            {
        //            case .success(let data):
        //                print("success")
        //            case .failure(let error):
        //                print("error")
        //            }
        //        }
        
    }
    
    override func viewWillLayoutSubviews()
    {
        super.viewWillLayoutSubviews()
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
}

//MARK: - UICollectionViewDataSource
extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 17
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCell", for: indexPath) as! BookCell
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.3
        cell.layer.shadowRadius = 4
        cell.clipsToBounds = false
        cell.layer.cornerRadius = 5
        print("IndexPath Section:\(indexPath.section)")
        print("IndexPath Row:\(indexPath.row)")
        print("IndexPath Item:\(indexPath.item)")
        return cell
    }
}

extension ListViewController: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columns: CGFloat = 2
        let height: CGFloat = 300
        let interval:CGFloat = 16
        
        let intervalSum: CGFloat = interval * (columns - 1)
        return CGSize(width: (collectionView.frame.width - intervalSum - 16)/columns, height: height)
    }
}

