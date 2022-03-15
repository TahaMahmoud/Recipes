//
//  RecipeDataViewModel.swift
//  Recipes
//
//  Created by Taha on 15/03/2022.
//

import Foundation

class RecipeDataViewModel  {
    
    var recipeImage: String?
    var recipeName: String?
    var recipeHeadline: String?
    var fats: String?
    var carbos: String?
    var fibers: String?
    var calories: String?
    var time: String?
    var proteins: String?
    var favorites: String?
    var descriptionText: String?
    var ingredients: String?

    init(recipe: Recipe) {
        
        recipeImage = recipe.image
        recipeName = recipe.name
        recipeHeadline = recipe.headline
        fats = recipe.fats
        carbos = recipe.carbos
        fibers = recipe.fibers
        calories = recipe.calories
        time = recipe.time
        proteins = recipe.proteins
        favorites = "\(recipe.favorites ?? 0)"
        descriptionText = recipe.recipeDescription
        ingredients = recipe.ingredients?.joined(separator: ", ")
        
    }
    
    
}
