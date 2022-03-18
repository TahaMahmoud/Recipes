//
//  RecipesListViewModelTests.swift
//  RecipesTests
//
//  Created by Taha on 18/03/2022.
//

import XCTest
import RxSwift
@testable import Recipes

class RecipesListViewModelTests: XCTestCase {

    var sut: RecipesViewModel!
    var interactorMock: RecipesInteractorMock!
    var coordinatorMock: RecipesCoordinatorMock!
    
    var disposeBag: DisposeBag!
    
    override func setUpWithError() throws {
    
        interactorMock = RecipesInteractorMock()
        coordinatorMock = RecipesCoordinatorMock()
        
        sut = RecipesViewModel(recipesInteractor: interactorMock, coordinator: coordinatorMock)
        
        disposeBag = DisposeBag()
    }

    override func tearDownWithError() throws {
        
        disposeBag = nil
        
        interactorMock = nil
        coordinatorMock = nil
        
        sut = nil
        
    }

    func testInit() {
        XCTAssertNotNil(interactorMock)
        XCTAssertNotNil(coordinatorMock)
        XCTAssertNotNil(sut)
    }

}
