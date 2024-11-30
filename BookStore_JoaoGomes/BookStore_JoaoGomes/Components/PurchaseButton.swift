//
//  PurchaseButton.swift
//  BookStore_JoaoGomes
//
//  Created by João Gomes on 30/11/2024.
//

import UIKit

@IBDesignable
class PurchaseButton: UIButton
{
    @IBInspectable var cornerRadius: CGFloat = 5
    {
        didSet
        {
            self.layer.cornerRadius = CGFloat(cornerRadius)
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
        self.clipsToBounds = true
        self.layer.cornerRadius = self.cornerRadius
    }
}
