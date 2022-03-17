//
//  RecipeCellViewModel.swift
//  Recipes
//
//  Created by Taha on 14/03/2022.
//

import Foundation

class RecipeCellViewModel  {
    
    var name: String?
    var recipeDescription: String?
    var image: String?
    
    var isFavourite: Bool?
    
    init(recipe: Recipe) {
        name = recipe.name
        recipeDescription = recipe.recipeDescription
        image = recipe.image
        isFavourite = recipe.isFavourited
    }
}
