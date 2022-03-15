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
}

class RecipeDetailsViewModel: RecipeDetailsViewModelInput, RecipeDetailsViewModelOutput {
    
    private let coordinator: RecipeDetailsCoordinator
    let disposeBag = DisposeBag()
    
    var recipeDetails: PublishSubject<RecipeDataViewModel> = .init()
    var error: PublishSubject<String> = .init()

    var recipe: Recipe
    
    private let recipeDetailsInteractor: RecipeDetailsInteractorProtocol

    init(recipeDetailsInteractor: RecipeDetailsInteractorProtocol = RecipeDetailsInteractor(), coordinator: RecipeDetailsCoordinator, recipe: Recipe) {
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
}
