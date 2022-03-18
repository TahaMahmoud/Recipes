//
//  RecipeDetailsViewModel.swift
//  Recipes
//
//  Created by Taha on 15/03/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol RecipeDetailsViewModelOutput {
    var error: PublishSubject<String> { get set }

}

protocol RecipeDetailsViewModelInput {
    func viewDidLoad()
    func favourite()
}

class RecipeDetailsViewModel: RecipeDetailsViewModelInput, RecipeDetailsViewModelOutput {
    
    private let coordinator: RecipeDetailsCoordinatorProtocol
    let disposeBag = DisposeBag()
    
    var recipeDetails: PublishSubject<RecipeDataViewModel> = .init()
    var error: PublishSubject<String> = .init()

    var recipe: Recipe
    
    private let recipeDetailsInteractor: RecipeDetailsInteractorProtocol

    init(recipeDetailsInteractor: RecipeDetailsInteractorProtocol = RecipeDetailsInteractor(), coordinator: RecipeDetailsCoordinatorProtocol, recipe: Recipe) {
        self.recipeDetailsInteractor = recipeDetailsInteractor
        self.coordinator = coordinator
        self.recipe = recipe
    }
    
    func viewDidLoad(){
        loadRecipeDetails()
    }
                
    func loadRecipeDetails() {
        let recipeData = RecipeDataViewModel(recipe: recipe)
        recipeDetails.onNext(recipeData)
    }
    
    func favourite() {
        if recipe.isFavourited ?? false {
            recipeDetailsInteractor.unfavouriteRecipe(recipeID: recipe.recipeID ?? "")
            recipe.isFavourited = false
            loadRecipeDetails()
        } else {
            let recipeToUnfavourited = FavouriteModel()
            recipeToUnfavourited.recipeID = recipe.recipeID ?? ""
            recipeDetailsInteractor.favouriteRecipe(favouriteModel: recipeToUnfavourited)
            recipe.isFavourited = true
            loadRecipeDetails()
        }
    }

}
