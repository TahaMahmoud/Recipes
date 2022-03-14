//
//  RecipeModel.swift
//  Recipes
//
//  Created by Taha on 14/03/2022.
//

import RealmSwift

// MARK: ArticleDetails Model -

class RecipeModel: Object {
    
    @objc dynamic var recipeID = "", fats = "", name = "", time = ""
    @objc dynamic var image = ""
    @objc dynamic var weeks = [""]
    @objc dynamic var carbos = "", fibers = ""
    @objc dynamic var rating = 0.0
    @objc dynamic var country = ""
    @objc dynamic var ratings = 0
    @objc dynamic var calories = "", headline = ""
    @objc dynamic var keywords = [""], products = [""]
    @objc dynamic var proteins = ""
    @objc dynamic var favorites = 0, difficulty = 0
    @objc dynamic var recipeDescription: String?
    @objc dynamic var highlighted = false
    @objc dynamic var ingredients = [""]
    @objc dynamic var incompatibilities = [""]
    @objc dynamic var deliverableIngredients = [""]
    @objc dynamic var undeliverableIngredients = [""]
 
    
}
