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
    
    init(recipe: Recipe) {
        name = recipe.name
        recipeDescription = recipe.recipeDescription
        image = recipe.image
    }
}
