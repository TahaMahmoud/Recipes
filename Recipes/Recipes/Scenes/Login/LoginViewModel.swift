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
    
    func processPressed()
}

class LoginViewModel: LoginViewModelInput, LoginViewModelOutput {
    
    private let coordinator: LoginCoordinatorProtocol
    let disposeBag = DisposeBag()
        
    private let loginInteractor: LoginInteractorProtocol

    var validEmail: BehaviorRelay<Bool> = .init(value: false)
    var validPassword: BehaviorRelay<Bool> = .init(value: false)
    
    var error: PublishSubject<String> = .init()
    
    var loginEnabled: PublishSubject<Bool> = .init()
    
    init(loginInteractor: LoginInteractorProtocol = LoginInteractor(), coordinator: LoginCoordinatorProtocol) {
        self.loginInteractor = loginInteractor
        self.coordinator = coordinator
    }
    
    func viewDidLoad(){
        
    }
    
    func login(email: String, password: String) {
        
        if email == "" || password == "" {
            error.onNext("Email and Password couldn't be empty")
        } else {
            loginInteractor.login(email: email.lowercased(), password: password.lowercased()).subscribe { (isValidCredentials) in
                if isValidCredentials.element ?? false {
                    
                    self.coordinator.pushToRecipes()
                } else {
                    self.error.onNext("Wrong Email or Password")
                }
                
                }.disposed(by: disposeBag)
        }
        
    }
    
    func processPressed() {
        self.coordinator.pushToRecipes()
    }
             
    func validateEmail(email: String) {
                
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        if emailPred.evaluate(with: email) {
            validEmail.accept(true)
        } else {
            validEmail.accept(false)
        }
        
        enableLogin()
    }
    
    func validatePassword(password: String) {
        
        if password.count >= 6 {
            validPassword.accept(true)
        } else {
            validPassword.accept(false)
        }
        
        enableLogin()

    }

    internal func enableLogin() {
        if validEmail.value && validPassword.value {
            loginEnabled.onNext(true)
        } else {
            loginEnabled.onNext(false)
        }
    }
}
