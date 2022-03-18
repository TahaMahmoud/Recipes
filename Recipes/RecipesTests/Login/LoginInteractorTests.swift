//
//  TestLoginInteractor.swift
//  RecipesTests
//
//  Created by Taha on 17/03/2022.
//

import XCTest
import RxSwift

@testable import Recipes

class LoginInteractorTests: XCTestCase {

    var sut: LoginInteractor!
    
    var disposeBag: DisposeBag!
    
    override func setUpWithError() throws {
        sut = LoginInteractor()
        disposeBag = DisposeBag()
    }

    override func tearDownWithError() throws {
        disposeBag = nil
        sut = nil
    }

    func testInvalidEmail() {
        
        let expectation = self.expectation(description: #function)
        let recorder = Recorder<Bool>()
        recorder.on(valueObservable: sut.login(email: "taha@taha.com", password: "123456"))
            
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 2)
        XCTAssertEqual(recorder.items.last, false)

    }
    
    func testInvalidPassword() {
        
        let expectation = self.expectation(description: #function)
        let recorder = Recorder<Bool>()
        recorder.on(valueObservable: sut.login(email: "taha.nagy06@gmail.com", password: "1234560"))
            
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 2)
        XCTAssertEqual(recorder.items.last, false)

    }
    
    func testInvalidEmailAndPassword() {
        
        let expectation = self.expectation(description: #function)
        let recorder = Recorder<Bool>()
        recorder.on(valueObservable: sut.login(email: "taha@taha.com", password: "1234560"))
            
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 2)
        XCTAssertEqual(recorder.items.last, false)

    }

    func testValidData() {
        
        let expectation = self.expectation(description: #function)
        let recorder = Recorder<Bool>()
        recorder.on(valueObservable: sut.login(email: "taha.nagy06@gmail.com", password: "123456"))
            
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 2)
        XCTAssertEqual(recorder.items.last, true)

    }

    
}
