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
    var weeks = List<String>()
    @objc dynamic var carbos = "", fibers = ""
    @objc dynamic var rating = 0.0
    @objc dynamic var country = ""
    @objc dynamic var ratings = 0
    @objc dynamic var calories = "", headline = ""
    var keywords = List<String>()
    var products = List<String>()
    @objc dynamic var proteins = ""
    @objc dynamic var favorites = 0, difficulty = 0
    @objc dynamic var recipeDescription = ""
    @objc dynamic var highlighted = false
    var ingredients = List<String>()
    var incompatibilities = List<String>()
    var deliverableIngredients = List<String>()
    var undeliverableIngredients = List<String>()
 
    
}
