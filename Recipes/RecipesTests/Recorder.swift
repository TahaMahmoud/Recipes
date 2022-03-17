//
//  Recorder.swift
//  RecipesTests
//
//  Created by Taha on 17/03/2022.
//

// For Testing PublishSubject

import Foundation
import RxSwift

class Recorder<T> {
    
    var items = [T]()
    let bag = DisposeBag()

    func on(arraySubject: PublishSubject<[T]>) {
        arraySubject.subscribe(onNext: { value in
            self.items = value
        }).disposed(by: bag)
    }

    func on(valueSubject: PublishSubject<T>) {
        valueSubject.subscribe(onNext: { value in
            self.items.append(value)
        }).disposed(by: bag)
    }

    func on(arrayObservable: Observable<[T]>) {
        arrayObservable.subscribe(onNext: { value in
            self.items = value
        }).disposed(by: bag)
    }

    func on(valueObservable: Observable<T>) {
        valueObservable.subscribe(onNext: { value in
            self.items.append(value)
        }).disposed(by: bag)
    }

}

