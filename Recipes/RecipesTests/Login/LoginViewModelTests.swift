//
//  RecipesTests.swift
//  RecipesTests
//
//  Created by Taha on 14/03/2022.
//

import XCTest
import RxSwift

@testable import Recipes

class LoginViewModelTests: XCTestCase {

    var sut: LoginViewModel!
    var interactorMock: LoginInteractorMock!
    var coordinatorMock: LoginCoordinatorMock!
    
    var disposeBag: DisposeBag!
    
    override func setUpWithError() throws {
    
        interactorMock = LoginInteractorMock()
        coordinatorMock = LoginCoordinatorMock()
        
        sut = LoginViewModel(loginInteractor: interactorMock, coordinator: coordinatorMock)
        
        disposeBag = DisposeBag()
    }

    override func tearDownWithError() throws {
        
        disposeBag = nil
        
        interactorMock = nil
        coordinatorMock = nil
        
        sut = nil
        
    }

    func testValidateEmailFail() {
        sut.validateEmail(email: "taha")
        XCTAssertEqual(sut.validEmail.value, false)
    }

    func testValidateEmailSuccess() {
        sut.validateEmail(email: "taha.nagy06@gmail.com")
        XCTAssertEqual(sut.validEmail.value, true)
    }

    func testValidatePasswordFail() {
        sut.validatePassword(password: "123")
        XCTAssertEqual(sut.validPassword.value, false)
    }

    func testValidatePasswordSuccess() {
        sut.validatePassword(password: "123456")
        XCTAssertEqual(sut.validPassword.value, true)
    }
    
    func testLoginEmptyEmail() {
        sut.login(email: "", password: "")
        
        sut.error.subscribe { error in
            XCTAssertEqual(error.element, "Email and Password couldn't be empty")
        }.disposed(by: disposeBag)
        
    }
    
    func testLoginWithWrongCredentials() {
        
        sut.login(email: "taha@taha.com", password: "123456")
        
        sut.error.subscribe { error in
            XCTAssertEqual(error.element, "Wrong Email or Password")
        }.disposed(by: disposeBag)

    }
    
    func testLoginWithCorrectCredentials() {
        
        sut.login(email: "taha.nagy06@gmail.com", password: "123456")
        
        sut.error.subscribe { error in
            XCTAssertEqual(error.element, "Wrong Email or Password")
        }.disposed(by: disposeBag)

    }

    
}
