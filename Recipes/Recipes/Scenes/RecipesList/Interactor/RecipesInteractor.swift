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
    
    func saveCachedRecipesCount(count: Int)
    func getCachedRecipesCount() -> Int
    
    func saveRecipes(recipes: [RecipeModel])
    func removeCachedRecipes()

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
    
    func saveCachedRecipesCount(count: Int) {
        UserDefaultsManager.shared.saveInt(count, key: .cachedRecipesCounts)
    }
    
    func getCachedRecipesCount() -> Int {
        return UserDefaultsManager.shared.getInt(key: .cachedRecipesCounts) ?? 0
    }

    func saveRecipes(recipes: [RecipeModel]) {
        RealmManager.shared.add(recipes)
    }

    func removeCachedRecipes(){
        RealmManager.shared.deleteAllDataForObject(RecipeModel.self)
    }

}
