//
//  RecipesResponse.swift
//  Recipes
//
//  Created by Taha on 14/03/2022.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let recipe = try? newJSONDecoder().decode(Recipe.self, from: jsonData)

import Foundation

// MARK: - RecipesResponse

struct Recipe: Codable {
    
    let recipeID, fats, name, time: String?
    let image: String?
    let weeks: [String]?
    let carbos, fibers: String?
    let rating: Double?
    let country: String?
    let ratings: Int?
    let calories, headline: String?
    let keywords, products: [String]?
    let proteins: String?
    let favorites, difficulty: Int?
    let recipeDescription: String?
    let highlighted: Bool?
    let ingredients: [String]?
    let incompatibilities: [String]?
    let deliverableIngredients: [String]?
    let undeliverableIngredients: [String]?

    var isFavourited: Bool?
    
    enum CodingKeys: String, CodingKey {
        case fats, name, time, image, weeks, carbos, fibers, rating, country, ratings, calories, headline, keywords, products, proteins, favorites, difficulty, isFavourited
        case recipeID = "id"
        case recipeDescription = "description"
        case highlighted, ingredients, incompatibilities
        case deliverableIngredients = "deliverable_ingredients"
        case undeliverableIngredients = "undeliverable_ingredients"
    }
    
    func toRecipeModel() -> RecipeModel {
        
        let recipeObject = RecipeModel()
        recipeObject.recipeID = self.recipeID ?? ""
        recipeObject.fats = self.fats ?? ""
        recipeObject.name = self.name ?? ""
        recipeObject.time = self.time ?? ""
        recipeObject.image = self.image ?? ""
        recipeObject.weeks.append(objectsIn: self.weeks ?? [])
        recipeObject.carbos = self.carbos ?? ""
        recipeObject.fibers = self.fibers ?? ""
        recipeObject.rating = self.rating ?? 0.0
        recipeObject.country = self.country ?? ""
        recipeObject.ratings = self.ratings ?? 0
        recipeObject.calories = self.calories ?? ""
        recipeObject.headline = self.headline ?? ""
        recipeObject.keywords.append(objectsIn: self.keywords ?? [])
        recipeObject.products.append(objectsIn: self.products ?? [])
        recipeObject.proteins = self.proteins ?? ""
        recipeObject.favorites = self.favorites ?? 0
        recipeObject.difficulty = self.difficulty ?? 0
        recipeObject.recipeDescription = self.recipeDescription ?? ""
        recipeObject.highlighted = self.highlighted ?? false
        recipeObject.ingredients.append(objectsIn: self.ingredients ?? [])
        recipeObject.incompatibilities.append(objectsIn: self.incompatibilities ?? [])
        recipeObject.deliverableIngredients.append(objectsIn: self.deliverableIngredients ?? [])
        recipeObject.undeliverableIngredients.append(objectsIn: self.undeliverableIngredients ?? [])
        recipeObject.isFavourited = self.isFavourited ?? false
        
        return recipeObject

    }
}

