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
 
    @objc dynamic var isFavourited: Bool = false
    
    func toRecipe() -> Recipe {
        
        let recipe = Recipe(recipeID: self.recipeID, fats: self.fats , name: self.name, time: self.time, image: self.image, weeks: Array(self.weeks), carbos: self.carbos, fibers: self.fibers, rating: self.rating , country: self.country, ratings: self.ratings , calories: self.calories, headline: self.headline, keywords: Array(self.keywords) , products: Array(self.products), proteins: self.proteins, favorites: self.favorites, difficulty: self.difficulty, recipeDescription: self.recipeDescription, highlighted: self.highlighted, ingredients: Array(self.ingredients), incompatibilities: Array(self.incompatibilities), deliverableIngredients: Array(self.deliverableIngredients), undeliverableIngredients: Array(self.undeliverableIngredients), isFavourited: self.isFavourited)

        return recipe

    }
}
