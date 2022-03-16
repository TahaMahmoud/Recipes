//
//  AppCoordinator.swift
//  Recipes
//
//  Created by Taha on 14/03/2022.
//

import UIKit

protocol Coordinator: AnyObject {
    func start()
    func coordinate(to coordinator: Coordinator)
}

extension Coordinator {
    func coordinate(to coordinator: Coordinator) {
        coordinator.start()
    }
}


class AppCoordinator: Coordinator {
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController()
        if #available(iOS 13.0, *) {
            navigationController.overrideUserInterfaceStyle = .light
        }
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        // let recipesListCoordinator = RecipesCoordinator(navigationController: navigationController)
        
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
        coordinate(to: loginCoordinator)
    }
}
