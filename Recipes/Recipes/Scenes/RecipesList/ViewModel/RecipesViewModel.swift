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
                    
            self.saveRecipes(recipes: recipes.element ?? [])
            
        }.disposed(by: disposeBag)
    }
    
    private func fetchCachedRecipes() {
        recipesInteractor.fetchCachedRecipes().subscribe{ (recipesObjects) in
            
            // Convert [RecipeModel] to [Recipe]
            
            var recipes: [Recipe] = []
            
            for object in recipesObjects.element ?? [] {
                
                // Convert RecipeModel to Recipe
                recipes.append(self.recipe(recipeModel: object ?? RecipeModel()))
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
            recipesObjects.append(recipeModel(recipe: recipe))
        }
        
        recipesInteractor.saveRecipes(recipes: recipesObjects).subscribe{ (saveSuccess) in
            if !(saveSuccess.element ?? false) {
                self.error.onNext("Error Occured While Saving Recipes")
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
    
    func recipeModel(recipe: Recipe) -> RecipeModel {
        let recipeObject = RecipeModel()
        recipeObject.recipeID = recipe.recipeID ?? ""
        recipeObject.fats = recipe.fats ?? ""
        recipeObject.name = recipe.name ?? ""
        recipeObject.time = recipe.time ?? ""
        recipeObject.image = recipe.image ?? ""
        recipeObject.weeks.append(objectsIn: recipe.weeks ?? [])
        recipeObject.carbos = recipe.carbos ?? ""
        recipeObject.fibers = recipe.fibers ?? ""
        recipeObject.rating = recipe.rating ?? 0.0
        recipeObject.country = recipe.country ?? ""
        recipeObject.ratings = recipe.ratings ?? 0
        recipeObject.calories = recipe.calories ?? ""
        recipeObject.headline = recipe.headline ?? ""
        recipeObject.keywords.append(objectsIn: recipe.keywords ?? [])
        recipeObject.products.append(objectsIn: recipe.products ?? [])
        recipeObject.proteins = recipe.proteins ?? ""
        recipeObject.favorites = recipe.favorites ?? 0
        recipeObject.difficulty = recipe.difficulty ?? 0
        recipeObject.recipeDescription = recipe.recipeDescription ?? ""
        recipeObject.highlighted = recipe.highlighted ?? false
        recipeObject.ingredients.append(objectsIn: recipe.ingredients ?? [])
        recipeObject.incompatibilities.append(objectsIn: recipe.incompatibilities ?? [])
        recipeObject.deliverableIngredients.append(objectsIn: recipe.deliverableIngredients ?? [])
        recipeObject.undeliverableIngredients.append(objectsIn: recipe.undeliverableIngredients ?? [])

        return recipeObject
    }
    
    func recipe(recipeModel: RecipeModel) -> Recipe {
        let recipe = Recipe(recipeID: recipeModel.recipeID, fats: recipeModel.fats , name: recipeModel.name, time: recipeModel.time, image: recipeModel.image, weeks: Array(recipeModel.weeks), carbos: recipeModel.carbos, fibers: recipeModel.fibers, rating: recipeModel.rating , country: recipeModel.country, ratings: recipeModel.ratings , calories: recipeModel.calories, headline: recipeModel.headline, keywords: Array(recipeModel.keywords) , products: Array(recipeModel.products), proteins: recipeModel.proteins, favorites: recipeModel.favorites, difficulty: recipeModel.difficulty, recipeDescription: recipeModel.recipeDescription, highlighted: recipeModel.highlighted, ingredients: Array(recipeModel.ingredients), incompatibilities: Array(recipeModel.incompatibilities), deliverableIngredients: Array(recipeModel.deliverableIngredients), undeliverableIngredients: Array(recipeModel.undeliverableIngredients))

        return recipe
    }
    
}
