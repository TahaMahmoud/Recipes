//
//  LoginViewModel.swift
//  Recipes
//
//  Created by Taha on 16/03/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol LoginViewModelOutput {
    
}

protocol LoginViewModelInput {
    func viewDidLoad()
    
    func login(email: String, password: String)
    
    func validateEmail(email: String)
    func validatePassword(password: String)
}

class LoginViewModel: LoginViewModelInput, LoginViewModelOutput {
    
    private let coordinator: LoginCoordinator
    let disposeBag = DisposeBag()
        
    private let loginInteractor: LoginInteractorProtocol

    var validEmail: PublishSubject<Bool> = .init()
    var validPassword: PublishSubject<Bool> = .init()
    
    init(loginInteractor: LoginInteractorProtocol = LoginInteractor(), coordinator: LoginCoordinator) {
        self.loginInteractor = loginInteractor
        self.coordinator = coordinator
    }
    
    func viewDidLoad(){
        
    }
    
    func login(email: String, password: String) {
        
    }
             
    func validateEmail(email: String) {
                
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        if emailPred.evaluate(with: email) {
            validEmail.onNext(true)
        } else {
            validEmail.onNext(false)
        }
    }
    
    func validatePassword(password: String) {
        
        if password.count >= 6 {
            validPassword.onNext(true)
        } else {
            validPassword.onNext(false)
        }
    }

}
