//
//  UserDefaultsProtocols.swift
//  Recipes
//
//  Created by Taha on 15/03/2022.
//

import Foundation

protocol UserDefaultsProtocols {
    func saveString(_ string: String?, key: UserDefaultsKeys)
    func getString(key: UserDefaultsKeys) -> String?
    func saveBool(_ bool: Bool?, key: UserDefaultsKeys)
    func getBool(key: UserDefaultsKeys) -> Bool?
    func saveInt(_ int: Int?, key: UserDefaultsKeys)
    func getInt(key: UserDefaultsKeys) -> Int?
    func removeObject(key: UserDefaultsKeys)
}
