//
//  RecipeDetailsInteractor.swift
//  Recipes
//
//  Created by Taha on 15/03/2022.
//

import Foundation
import RxSwift

protocol RecipeDetailsInteractorProtocol: AnyObject {
    func favouriteRecipe(recipeID: String)
    func unfavouriteRecipe(recipeID: String)
}

class RecipeDetailsInteractor: RecipeDetailsInteractorProtocol {
    
    func favouriteRecipe(recipeID: String) {
        let predicate = NSPredicate(format: "recipeID == %@", recipeID)
        RealmManager.shared.update(RecipeModel.self, with: predicate)
    }
    
    func unfavouriteRecipe(recipeID: String) {
        let predicate = NSPredicate(format: "recipeID == %@", recipeID)
        RealmManager.shared.delete(RecipeModel.self, with: predicate)
    }
    
}
