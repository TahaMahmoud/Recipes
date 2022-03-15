//
//  RecipeDetailsCoordinator.swift
//  Recipes
//
//  Created by Taha on 15/03/2022.
//

import Foundation
import UIKit

protocol RecipeDetailsCoordinatorProtocol: AnyObject {

}

class RecipeDetailsCoordinator: Coordinator{
    
    unowned let navigationController: UINavigationController
    
    var recipe: Recipe
    
    init(navigationController: UINavigationController, recipe: Recipe) {
        self.navigationController = navigationController
        self.recipe = recipe
    }
    
    func start() {
        let recipeDetailsViewController = RecipeDetailsViewController()
        let recipeDetailsViewModel = RecipeDetailsViewModel(recipeDetailsInteractor: RecipeDetailsInteractor(), coordinator: self, recipe: recipe)
        recipeDetailsViewController.viewModel = recipeDetailsViewModel
        navigationController.pushViewController(recipeDetailsViewController, animated: true)
    }
}

extension RecipeDetailsCoordinator: RecipeDetailsCoordinatorProtocol {

}
