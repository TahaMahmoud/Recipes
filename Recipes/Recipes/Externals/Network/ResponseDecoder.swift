//
//  ResponseDecoder.swift
//  Recipes
//
//  Created by Taha on 14/03/2022.
//

import Foundation

protocol ResponseDecoder: Codable {
    init(data: Data) throws
}

extension ResponseDecoder  {
    init(data: Data) throws {
        let decoder = JSONDecoder()
        self = try decoder.decode(Self.self, from: data)
    }
}
