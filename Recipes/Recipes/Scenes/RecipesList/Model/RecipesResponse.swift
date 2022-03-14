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

    enum CodingKeys: String, CodingKey {
        case fats, name, time, image, weeks, carbos, fibers, rating, country, ratings, calories, headline, keywords, products, proteins, favorites, difficulty
        case recipeID = "id"
        case recipeDescription = "description"
        case highlighted, ingredients, incompatibilities
        case deliverableIngredients = "deliverable_ingredients"
        case undeliverableIngredients = "undeliverable_ingredients"
    }
    
}

