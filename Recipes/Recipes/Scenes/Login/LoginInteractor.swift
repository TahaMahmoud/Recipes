//
//  LoginInteractor.swift
//  Recipes
//
//  Created by Taha on 16/03/2022.
//

import Foundation
import RxSwift

protocol LoginInteractorProtocol: AnyObject {
    func login(email: String, password: String) -> Observable<(Bool)>
}

class LoginInteractor: LoginInteractorProtocol {
    
    let credentials: [String : String] = ["email": "taha@taha.com", "password": "123456"]
    
    func login(email: String, password: String) -> Observable<Bool> {
        return Observable.create {[weak self] (isValidCredential) -> Disposable in
                        
            if email == self?.credentials["email"] && password == self?.credentials["password"] {
                isValidCredential.onNext(true)
            } else {
                isValidCredential.onNext(false)
            }
            
            return Disposables.create()
        }

    }
    
    
}
