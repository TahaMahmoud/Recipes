//
//  StubGenerator.swift
//  RecipesTests
//
//  Created by Taha on 18/03/2022.
//

import Foundation
@testable import Recipes

class StubGenerator {

    func stubRecipes() -> [Recipe] {
        let path = Bundle.main.path(forResource: "Recipes", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let recipes = try! decoder.decode([Recipe].self, from: data)
        return recipes
    }

}
