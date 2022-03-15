//
//  RecipesCoordinator.swift
//  Recipes
//
//  Created by Taha on 14/03/2022.
//

import Foundation
import UIKit

protocol RecipesCoordinatorProtocol: AnyObject {
    func pushToRecipeDetails(with recipe: Recipe)
}

class RecipesCoordinator: Coordinator{
    
    unowned let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
    }
    
    func start() {
        let recipesViewController = RecipesViewController()
        let recipesViewModel = RecipesViewModel(recipesInteractor: RecipesInteractor(), coordinator: self)
        recipesViewController.viewModel = recipesViewModel
        navigationController.navigationBar.isHidden = false
        navigationController.pushViewController(recipesViewController, animated: true)
    }
}

extension RecipesCoordinator: RecipesCoordinatorProtocol {
    func pushToRecipeDetails(with recipe: Recipe) {
        let recipeDetailsCoordinator = RecipeDetailsCoordinator(navigationController: navigationController, recipe: recipe)
        recipeDetailsCoordinator.start()
    }
}
