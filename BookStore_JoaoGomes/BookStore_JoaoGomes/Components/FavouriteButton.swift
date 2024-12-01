//
//  FavouriteButton.swift
//  BookStore_JoaoGomes
//
//  Created by João Gomes on 01/12/2024.
//
import UIKit

class FavouriteButton: UIButton
{
    var isFavourited: Bool = false
    {
        didSet
        {
            if isFavourited
            {
                self.setImage(UIImage(named:"favorite_fill"), for: .normal)
                self.tintColor = .red
            }
            else
            {
                self.setImage(UIImage(named: "favorite_outline"), for: .normal)
                self.tintColor = .black
            }
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func prepareForInterfaceBuilder() {
        commonInit()
    }

    private func commonInit() {
        self.setImage(UIImage(named:"favorite_outline"), for: .normal)
        self.clipsToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 4
        self.backgroundColor = .white
        self.layer.cornerRadius = self.frame.height / 2
    }
    
}
