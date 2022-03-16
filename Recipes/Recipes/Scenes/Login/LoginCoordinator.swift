//
//  LoginCoordinator.swift
//  Recipes
//
//  Created by Taha on 16/03/2022.
//

import Foundation
import UIKit

protocol LoginCoordinatorProtocol: AnyObject {
    func pushToRecipes()
}

class LoginCoordinator: Coordinator{
    
    unowned let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
    }
    
    func start() {
        let loginViewController = LoginViewController()
        let loginViewModel = LoginViewModel(loginInteractor: LoginInteractor(), coordinator: self)
        loginViewController.viewModel = loginViewModel
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(loginViewController, animated: true)
    }
}

extension LoginCoordinator: LoginCoordinatorProtocol {
    func pushToRecipes() {
        let recipesCoordinator = RecipesCoordinator(navigationController: navigationController)
        recipesCoordinator.start()
    }
}
