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
    var interactorMock: LoginInteractor!
    var coordinatorMock: LoginCoordinatorMock!
    
    var disposeBag: DisposeBag!
    
    override func setUpWithError() throws {
    
        interactorMock = LoginInteractor()
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

        let expectation = self.expectation(description: #function)
        let recorder = Recorder<String>()
        recorder.on(valueSubject: sut.error)
        
        sut.login(email: "", password: "")

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 2)
        XCTAssertEqual(recorder.items.last, "Email and Password couldn't be empty")

    }
    
    func testLoginWithWrongCredentials() {
        
        let expectation = self.expectation(description: #function)
        let recorder = Recorder<String>()
        recorder.on(valueSubject: sut.error)
        
        sut.login(email: "taha@taha.com", password: "123456")

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 2)
        XCTAssertEqual(recorder.items.last, "Wrong Email or Password")

    }
    
    func testLoginWithCorrectCredentials() {
        sut.login(email: "taha.nagy06@gmail.com", password: "123456")
        XCTAssertEqual(coordinatorMock.isLoginDone, true)
    }
    
    func testProceesPressed() {
        sut.processPressed()
        XCTAssertEqual(coordinatorMock.isLoginDone, true)
    }
    
    func testEnableLoginFail() {
        
        let expectation = self.expectation(description: #function)
        let recorder = Recorder<Bool>()
        recorder.on(valueSubject: sut.loginEnabled)

        // Given
        sut.validEmail.accept(true)
        sut.validPassword.accept(false)
        
        // Do
        sut.enableLogin()

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 2)
        
        // Test
        XCTAssertEqual(recorder.items.last, false)

    }

    func testEnableLoginSuccess() {
        
        let expectation = self.expectation(description: #function)
        let recorder = Recorder<Bool>()
        recorder.on(valueSubject: sut.loginEnabled)

        // Given
        sut.validEmail.accept(true)
        sut.validPassword.accept(true)
        
        // Do
        sut.enableLogin()

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 2)
        
        // Test
        XCTAssertEqual(recorder.items.last, true)

    }

}

