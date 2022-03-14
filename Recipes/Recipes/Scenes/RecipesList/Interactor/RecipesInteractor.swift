//
//  RecipesInteractor.swift
//  Recipes
//
//  Created by Taha on 14/03/2022.
//

import Foundation
import RxSwift

protocol RecipesInteractorProtocol: AnyObject {
    
    func fetchRemoteRecipes() -> Observable<([Recipe])>
    
    func fetchCachedRecipes() -> Observable<([RecipeModel?])>
    func saveRecipes(recipes: [RecipeModel]) -> Observable<(Bool)>
}

class RecipesInteractor: RecipesInteractorProtocol {
    
    var networkManager: NetworkProtocol
    
    init(networkManager: NetworkProtocol = AlamofireManager()) {
        self.networkManager = networkManager
    }

    var request: RecipesRequest?

    func fetchRemoteRecipes() -> Observable<([Recipe])> {
        return Observable.create {[weak self] (observer) -> Disposable in
            self?.networkManager.callRequest([Recipe].self, endpoint: RecipesRequest.getRecipes) { (result) in
                switch result {
                case .success(let value):
                    observer.onNext(value)
                case .failure(let error):
                    print(error)
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
        
    }
    
    func saveRecipes(recipes: [RecipeModel]) -> Observable<(Bool)> {
        return Observable.create {[weak self] (saveSuccess) -> Disposable in

            do {
                RealmManager.shared.add(recipes)
                saveSuccess.onNext(true)
            } catch {
                print("Error")
                saveSuccess.onNext(false)
            }

            return Disposables.create()
        }
        
    }
    
    func fetchCachedRecipes() -> Observable<([RecipeModel?])> {
        return Observable.create { (observer) -> Disposable in
            do {
                let objects = RealmManager.shared.retrieveAllDataForObject(RecipeModel.self).map { $0 as? RecipeModel }
                observer.onNext(objects)
                
            } catch {
                print("Error")
                observer.onNext([])
            }
            
            return Disposables.create()
        }
    }
}
