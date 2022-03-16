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
    
    let credientials: [String : Any] = ["email": "taha.nagy06@gmail.com",
                        "password": 123456]
    
    func login(email: String, password: String) -> Observable<Bool> {
        return Observable.create {[weak self] (isValidCrediential) -> Disposable
            in
            isValidCrediential.onNext(true)
            return Disposables.create()
        }

    }
    
    
}
