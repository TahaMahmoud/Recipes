//
//  UIImage+CornerRadius.swift
//  Recipes
//
//  Created by Taha on 14/03/2022.
//

import UIKit

@IBDesignable
class CornerRadiusImage: UIImageView {
        
    @IBInspectable var cornerRadiusValue: CGFloat = 10.0 {
        didSet {
            setUpView()
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }

    func setUpView() {
        layer.cornerRadius = cornerRadiusValue
        clipsToBounds = true
    }

}
