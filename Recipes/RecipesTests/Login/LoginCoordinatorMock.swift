//
//  LoginCoordinatorMock.swift
//  RecipesTests
//
//  Created by Taha on 17/03/2022.
//

import XCTest
import RxSwift

@testable import Recipes

class LoginCoordinatorMock: LoginCoordinatorProtocol {
        
    var isLoginDone = false
    
    func pushToRecipes() {
        // Simulate Navigation
        isLoginDone = true
    }
    
}

