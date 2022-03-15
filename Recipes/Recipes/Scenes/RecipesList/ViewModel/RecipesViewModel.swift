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
    func viewDidLoad()
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
    
    init(recipesInteractor: RecipesInteractorProtocol = RecipesInteractor(networkManager: AlamofireManager()), coordinator: RecipesCoordinator) {
        self.recipesInteractor = recipesInteractor
        self.coordinator = coordinator
        bindSelectedRecipe()
    }
    
    func viewDidLoad(){
        fetchRecipes()
    }
    
    private func fetchRecipes() {
        
        recipes.accept([])
        
        indicator.onNext(true)
        
        if Helper.checkConnection() {
            fetchRemoteRecipes()
        } else {
            // Fetch Cached Recipes
            fetchCachedRecipes()
            error.onNext("Check Internet Connection")
        }
        
    }
    
    private func fetchRemoteRecipes() {
        recipesInteractor.fetchRemoteRecipes().subscribe{ (recipes) in

            self.recipes.accept(recipes.element ?? [])
            self.indicator.onNext(false)
            
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
            
            var recipes: [Recipe] = []
            
            for object in recipesObjects.element ?? [] {
                
                // Convert RecipeModel to Recipe
                recipes.append((object?.toRecipe())!)
            }
            
            self.recipes.accept(recipes)
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
    
    func bindSelectedRecipe() {
        navigateToItemDetails.asObservable().subscribe { [weak self] (recipe) in
            guard let recipe = recipe.element else { return }
            self?.coordinator.pushToRecipeDetails(with: recipe)
        }.disposed(by: disposeBag)
    }
            
}
