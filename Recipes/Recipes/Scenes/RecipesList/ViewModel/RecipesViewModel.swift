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
    
    init(recipesInteractor: RecipesInteractorProtocol = RecipesInteractor(networkManager: AlamofireManager()), coordinator: RecipesCoordinator) {
        self.recipesInteractor = recipesInteractor
        self.coordinator = coordinator
        bindSelectedRecipe()
    }
    
    func viewDidLoad(){
        fetchRecipes()
    }
    
    private func fetchRecipes() {
        
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
        recipesInteractor.fetchRemoteRecipes().subscribe{ (recipesObjects) in
            
            // Convert [RecipeModel] to [Recipe]
            
            var recipes: [Recipe] = []
            
            for object in recipesObjects {
                
                // Convert RecipeModel To Recipe
                let recipe = Recipe(recipeID: object?.recipeID, fats: object?.fats , name: object?.name ?? "", time: object?.time ?? "", image: object?.image, weeks: object?.weeks, carbos: object?.carbos ?? "", fibers: object?.fibers ?? "", rating: object?.rating ?? 0.0, country: object?.country ?? "", ratings: object?.ratings ?? 0, calories: object?.calories ?? "", headline: object?.headline ?? "", keywords: object?.keywords ?? [], products: object?.products ?? [], proteins: object?.proteins ?? "", favorites: object?.favorites ?? 0, difficulty: object?.difficulty ?? 0, recipeDescription: object?.recipeDescription ?? "", highlighted: object?.highlighted ?? false, ingredients: object?.ingredients ?? [], incompatibilities: object?.incompatibilities ?? [], deliverableIngredients: object?.deliverableIngredients ?? [], undeliverableIngredients: object?.undeliverableIngredients ?? [])
                
                recipes.append(objects)
            }

            
            self.recipes.accept(recipes.element)
            self.indicator.onNext(false)
            
            self.saveRecipes(recipes: recipes.element)
            
        }.disposed(by: disposeBag)
    }
    
    private func fetchCachedRecipes() {
        recipesInteractor.fetchCachedRecipes().subscribe{ (recipes) in
            self.recipes.accept(recipes.element ?? [])
            self.indicator.onNext(false)
        }.disposed(by: disposeBag)
    }
    
    private func saveRecipes(recipes: [Recipe]) {
        recipesInteractor.saveRecipes(recipes: recipes).subscribe{ (status) in
            if error {
                
            }
        }.disposed(by: disposeBag)
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
