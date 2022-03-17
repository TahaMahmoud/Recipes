//
//  LoginInteractorMock.swift
//  RecipesTests
//
//  Created by Taha on 17/03/2022.
//

import Foundation
import RxSwift

@testable import Recipes

class LoginInteractorMock: LoginInteractorProtocol {
    
    let credentials: [String : String] = ["email": "taha.nagy06@gmail.com", "password": "123456"]

    func login(email: String, password: String) -> Observable<(Bool)> {
        return Observable.create { [weak self] (isValidCredential) -> Disposable in
            if email == self?.credentials["email"] && password == self?.credentials["password"] {
                isValidCredential.onNext(true)
            } else {
                isValidCredential.onNext(false)
            }
            return Disposables.create()
        }

    }
    
}
