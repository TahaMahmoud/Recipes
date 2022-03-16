//
//  RecipesViewModel.swift
//  Recipes
//
//  Created by Taha on 14/03/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol RecipesViewModelOutput {
    func recipeViewModelAtIndexPath(_ indexPath: IndexPath) -> RecipeCellViewModel
    
    var indicator: PublishSubject<Bool> { get set }
    var error: PublishSubject<String> { get set }

}

protocol RecipesViewModelInput {
    func viewDidLoad(refresh: Bool)
    func didSelectItemAtIndexPath(_ indexPath: IndexPath)
}

class RecipesViewModel: RecipesViewModelInput, RecipesViewModelOutput {
    
    private let coordinator: RecipesCoordinator
    let disposeBag = DisposeBag()
    
    var recipes: BehaviorRelay<[Recipe]> = .init(value: [])
    var navigateToItemDetails: PublishSubject<Recipe> = .init()
    
    var indicator: PublishSubject<Bool> = .init()
    var error: PublishSubject<String> = .init()

    private let recipesInteractor: RecipesInteractorProtocol

    private var cachedRecipesCount = 0
    private var favouriteRecipes: [String:Bool] = [:]
    
    init(recipesInteractor: RecipesInteractorProtocol = RecipesInteractor(networkManager: AlamofireManager()), coordinator: RecipesCoordinator) {
        self.recipesInteractor = recipesInteractor
        self.coordinator = coordinator
        bindSelectedRecipe()
    }
    
    func viewDidLoad(refresh: Bool){
        fetchFavourites()
        fetchRecipes(refresh: refresh)
    }
    
    private func fetchFavourites() {
        favouriteRecipes.removeAll()
        
        let fetchedFavourites = recipesInteractor.fetchFavourites()

        // Add Favourits to favourites dictionary
        for fav in fetchedFavourites {
            // Add RecipeID to dictionary as a key
            self.favouriteRecipes[fav?.recipeID ?? ""] = true
        }
            
    }
    
    private func fetchRecipes(refresh: Bool) {

        if recipes.value.count == 0 || refresh {
            
            recipes.accept([])
            indicator.onNext(true)

            if Helper.checkConnection() {
                fetchRemoteRecipes()
            } else {
                // Fetch Cached Recipes
                fetchCachedRecipes()
                error.onNext("Check Internet Connection")
            }
        } else {
            updateRecipesWithFavourite()
        }
    }
    
    private func updateRecipesWithFavourite() {
        var updatedRecipes: [Recipe] = []
        
        for fetchedRecipe in recipes.value {
            var recipe = fetchedRecipe
            
            if let _ = self.favouriteRecipes[fetchedRecipe.recipeID ?? ""] {
                // Key exist -> recipe is favourited
                recipe.isFavourited = true
            }
            
            updatedRecipes.append(recipe)
        }
        
        recipes.accept(updatedRecipes)
        
    }
    
    private func fetchRemoteRecipes() {
        recipesInteractor.fetchRemoteRecipes().subscribe{ (recipes) in

            self.recipes.accept(recipes.element ?? [])
            self.indicator.onNext(false)
            
            // Update Recipes with isFavourite option
            self.updateRecipesWithFavourite()
                    
            if recipes.element?.count != self.cachedRecipesCount {
                self.recipesInteractor.removeCachedRecipes()
                self.saveRecipes(recipes: recipes.element ?? [])
                self.cachedRecipesCount = recipes.element?.count ?? 0
            }
                        
        }.disposed(by: disposeBag)
    }
    
    private func fetchCachedRecipes() {
        recipesInteractor.fetchCachedRecipes().subscribe{ (recipesObjects) in
            
            // Convert [RecipeModel] to [Recipe]
            
            var cachedrecipes: [Recipe] = []
            
            for object in recipesObjects.element ?? [] {
                
                // Convert RecipeModel to Recipe
                cachedrecipes.append((object?.toRecipe())!)
            }
            
            self.recipes.accept(cachedrecipes)
            
            // Update Recipes with isFavourite option
            self.updateRecipesWithFavourite()
            
            self.indicator.onNext(false)
                
            }.disposed(by: disposeBag)
    }
    
    private func saveRecipes(recipes: [Recipe]) {
        
        // Convert [Recipe] to [RecipeModel]

        var recipesObjects: [RecipeModel] = []
        
        for recipe in recipes {
            
            // Convert Recipe to RecipeModel
            recipesObjects.append(recipe.toRecipeModel())
        }
        
        recipesInteractor.saveRecipes(recipes: recipesObjects)
        recipesInteractor.saveCachedRecipesCount(count: recipes.count)
            
    }
    
    func recipeViewModelAtIndexPath(_ indexPath: IndexPath) -> RecipeCellViewModel {
        return RecipeCellViewModel(recipe: recipes.value[indexPath.row])
    }
    
    func didSelectItemAtIndexPath(_ indexPath: IndexPath) {
        let recipe = recipes.value[indexPath.row]
        navigateToItemDetails.onNext(recipe)
    }
    
    private func bindSelectedRecipe() {
        navigateToItemDetails.asObservable().subscribe { [weak self] (recipe) in
            guard let recipe = recipe.element else { return }
            self?.coordinator.pushToRecipeDetails(with: recipe)
        }.disposed(by: disposeBag)
    }
            
}
