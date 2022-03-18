//
//  RecipesCoordinatorMock.swift
//  RecipesTests
//
//  Created by Taha on 18/03/2022.
//

import Foundation
@testable import Recipes

class RecipesCoordinatorMock: RecipesCoordinatorProtocol {
    
    var isPushToDetailsCalled = false
    var isLoginCalled = false
    
    func pushToRecipeDetails(with recipe: Recipe) {
        isPushToDetailsCalled = true
    }
    
    func pushToLogin() {
        isLoginCalled = true
    }
    
}
