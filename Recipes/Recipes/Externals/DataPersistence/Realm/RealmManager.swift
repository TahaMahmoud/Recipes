//
//  RealmManager.swift
//  Recipes
//
//  Created by Taha on 14/03/2022.
//

import Foundation
import RealmSwift

protocol DataPersistenceManager {
    
    func retrieveAllDataForObject(_ T : Object.Type) -> [Object]
    func deleteAllDataForObject(_ T : Object.Type)
    func replaceAllDataForObject(_ T : Object.Type, with objects : [Object])
    
    func add(_ objects : [Object], completion : @escaping() -> ())
    func add(_ objects : [Object])
    func add(_ object: Object)
    
    func update(_ block: @escaping ()->Void)
    
    func delete(_ objects : [Object])
    func delete(_ object : Object.Type, with predicate: NSPredicate)
    
    func getFileURL() -> String
}

class RealmManager: NSObject, DataPersistenceManager {
    
    let realmObject = try! Realm()

    static var shared: DataPersistenceManager = RealmManager()
        
    func retrieveAllDataForObject(_ T : Object.Type) -> [Object] {
        var objects = [Object]()
        for result in realmObject.objects(T) {
            objects.append(result)
        }
        return objects
    }
    
    func deleteAllDataForObject(_ T : Object.Type) {
        self.delete(self.retrieveAllDataForObject(T))
    }
    
    func replaceAllDataForObject(_ T : Object.Type, with objects : [Object]) {
        deleteAllDataForObject(T)
        add(objects)
    }
    
    func add(_ objects : [Object], completion : @escaping() -> ()) {
        try! realmObject.write{
            realmObject.add(objects)
            completion()
        }
    }
    
    func add(_ objects : [Object]) {
        try! realmObject.write{
            realmObject.add(objects)
        }
    }
    
    func add(_ object: Object) {
        try! realmObject.write{
            realmObject.add(object)
        }
    }
    
    func update(_ block: @escaping ()->Void) {
        try! realmObject.write(block)
    }
    
    func delete(_ objects : [Object]) {
        try! realmObject.write{
            realmObject.delete(objects)
        }
    }
    
    func delete(_ object : Object.Type, with predicate: NSPredicate) {
        let articles = realmObject.objects(object)
        
        let articlesToDelete  = articles.filter(predicate)
            
        try! realmObject.write {
            realmObject.delete(articlesToDelete)
        }
    }
    
    func getFileURL() -> String {
        return realmObject.configuration.fileURL!.path
    }
    
}
