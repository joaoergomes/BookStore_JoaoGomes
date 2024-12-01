//
//  GradientView.swift
//  BookStore_JoaoGomes
//
//  Created by João Gomes on 30/11/2024.
//
import UIKit

@IBDesignable class GradientView: UIView
{
    var gradientLayer: CAGradientLayer{ layer as! CAGradientLayer }
    override public class var layerClass: AnyClass { CAGradientLayer.self }
    
    @IBInspectable var startColor: UIColor = .clear
    {
        didSet {changeGradientColors()}
    }
    @IBInspectable var endColor: UIColor = .black
    {
        didSet {changeGradientColors()}
    }
    
    @IBInspectable var startLocation: CGFloat = 0
    {
        didSet {changeGradientLocations()}
    }
    
    @IBInspectable var endLocation: CGFloat = 1
    {
        didSet {changeGradientLocations()}
    }
    
    
    func changeGradientColors()
    {
        self.gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
    
    func changeGradientLocations()
    {
        self.gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            super.traitCollectionDidChange(previousTraitCollection)
            changeGradientLocations()
            changeGradientColors()
        }
}
