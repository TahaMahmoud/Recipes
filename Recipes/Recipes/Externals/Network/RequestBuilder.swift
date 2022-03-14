//
//  RequestBuilder.swift
//  Recipes
//
//  Created by Taha on 14/03/2022.
//

import Foundation
import Alamofire

protocol URLRequestBuilder: URLRequestConvertible,RequestHandler {
    var mainURL: URL { get }
    
    var requestURL: URL { get }
    
    var path: String { get }
    
    var headers: HTTPHeaders { get }
    
    var parameters: Parameters? { get }
    
    var method: HTTPMethod { get }
    
    var encoding: ParameterEncoding { get }
    
    var urlRequest: URLRequest { get }
    
}

extension URLRequestBuilder {
    var mainURL: URL {
        return URL(string: "https://api.npoint.io/43427003d33f1f6b51cc")!
    }
    
    var requestURL: URL {
        return mainURL.appendingPathComponent(path)
    }
    
    var headers: HTTPHeaders {
        var headers = HTTPHeaders()
        // Add Headers
        // headers.add(HTTPHeader(name: "Key", value: "Value"))
        
        return headers
    }
    
    
    var defaultParams: Parameters {
        var param = Parameters()
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
        for header in headers {
            request.addValue(header.value, forHTTPHeaderField: header.name)
        }
        return request
    }
    
    
    func asURLRequest() throws -> URLRequest {
        return try encoding.encode(urlRequest, with: parameters)
    }
    
}
