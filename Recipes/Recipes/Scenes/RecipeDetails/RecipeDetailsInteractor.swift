//
//  RecipeDetailsInteractor.swift
//  Recipes
//
//  Created by Taha on 15/03/2022.
//

import Foundation
import RxSwift

protocol RecipeDetailsInteractorProtocol: AnyObject {
    func favouriteRecipe(favouriteModel: FavouriteModel)
    func unfavouriteRecipe(recipeID: String)
}

class RecipeDetailsInteractor: RecipeDetailsInteractorProtocol {
    
    func favouriteRecipe(favouriteModel: FavouriteModel) {
        RealmManager.shared.add(favouriteModel)
    }
    
    func unfavouriteRecipe(recipeID: String) {
        let predicate = NSPredicate(format: "recipeID == %@", recipeID)
        RealmManager.shared.delete(FavouriteModel.self, with: predicate)
    }
    
}
