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
    
    func pushToLogin()
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
        navigationController.setViewControllers([recipesViewController], animated: true)
    }
}

extension RecipesCoordinator: RecipesCoordinatorProtocol {
    func pushToRecipeDetails(with recipe: Recipe) {
        let recipeDetailsCoordinator = RecipeDetailsCoordinator(navigationController: navigationController, recipe: recipe)
        recipeDetailsCoordinator.start()
    }
    
    func pushToLogin() {
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
        loginCoordinator.start()
    }
    
}
