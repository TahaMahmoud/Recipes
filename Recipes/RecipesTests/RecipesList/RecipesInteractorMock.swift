//
//  RecipesInteractorMock.swift
//  RecipesTests
//
//  Created by Taha on 18/03/2022.
//

import Foundation
import RxSwift
@testable import Recipes

class RecipesInteractorMock: RecipesInteractorProtocol {
    
    var isSaveCachedRecipesCountCalled = false
    
    init() {
        
    }
    
    func fetchRemoteRecipes() -> Observable<([Recipe])> {
        
        let recipes = StubGenerator().stubRecipes()
        return Observable.create {(observer) -> Disposable in
            
            observer.onNext(recipes)
            
            return Disposables.create()
        }

    }
    
    func fetchCachedRecipes() -> Observable<([RecipeModel?])> {
        
    }
    
    func saveCachedRecipesCount(count: Int) {
        
    }
    
    func getCachedRecipesCount() -> Int {
        
    }
    
    func saveRecipes(recipes: [RecipeModel]) {
        
    }
    
    func removeCachedRecipes() {
        
    }
    
    func fetchFavourites() -> [FavouriteModel?] {
        
    }
    
    func favouriteRecipe(favouriteModel: FavouriteModel) {
        
    }
    
    func unfavouriteRecipe(recipeID: String) {
        
    }
    
}
