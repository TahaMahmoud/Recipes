//
//  RecipesRequest.swift
//  Recipes
//
//  Created by Taha on 14/03/2022.
//

import Foundation
import Alamofire

enum RecipesRequest: Endpoint {

    case getRecipes

    var path: String {
        switch self {
        
        case .getRecipes:
            return "43427003d33f1f6b51cc"
        }
    }
    
    var headers: HTTPHeaders {
        let headers = defaultHeaders
        return headers
    }

    var parameters: Parameters? {
        let param = defaultParams
        switch  self {
        case .getRecipes:
            break
        }

        return param
    }
    
    var method: HTTPMethod {
        switch self {

        case .getRecipes:
            return .get
            
        }
    }
}
