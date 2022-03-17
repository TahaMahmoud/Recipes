//
//  RequestBuilder.swift
//  Recipes
//
//  Created by Taha on 14/03/2022.
//

import Foundation
import Alamofire

protocol Endpoint: URLRequestConvertible {
    var baseURL: String { get }
    var path: String { get }
    var requestURL: URL { get }
    var headers: HTTPHeaders { get }
    var parameters: Parameters? { get }
    var encoding: ParameterEncoding { get }
    var method: HTTPMethod { get }
    var urlRequest: URLRequest { get }
}

extension Endpoint {
    var baseURL: String {
        return "https://api.npoint.io/"
    }
    
    var requestURL: URL {
        return URL(string: baseURL + path)!
    }
    
    var defaultHeaders: HTTPHeaders {
        var headers = HTTPHeaders()
        
        // Add Headers
        // headers.add(name: "Content-Type", value: "application/json")
        return headers
    }
    
    var defaultParams: Parameters {
        let param = Parameters()
        return param
    }
    
    var encoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        defaultHeaders.forEach { header in
            request.addValue(header.value, forHTTPHeaderField: header.name)
        }
        return request
    }
    
    func asURLRequest() throws -> URLRequest {
        return try encoding.encode(urlRequest, with: parameters)
    }
}

