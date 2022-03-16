//
//  RecipeTableViewCell.swift
//  Recipes
//
//  Created by Taha on 14/03/2022.
//

import UIKit
import Kingfisher

class RecipeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeDesc: UITextView!
    
    @IBOutlet weak var recipeImage: CornerRadiusImage!
    
    var isFavourite: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ viewModel: RecipeCellViewModel) {
        recipeName.text = viewModel.name
        recipeDesc.text = viewModel.recipeDescription
        
        guard let imageURL = URL(string: viewModel.image ?? "") else {return}
        recipeImage.kf.setImage(with: imageURL)
        
        isFavourite = viewModel.isFavourite ?? false
    }
    
}
