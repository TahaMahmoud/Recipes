//
//  RequestHandler.swift
//  Recipes
//
//  Created by Taha on 14/03/2022.
//

import Foundation
import Alamofire

typealias CallResponse<T> = ((ServerResponse<T>) -> Void)?

protocol RequestHandler: HandleRequestResponse { }

enum ServerResponse<T> {
    case success(T), failure(Error)
}

extension RequestHandler {

    func cancelRequest() {
        
    }
}

extension RequestHandler where Self: URLRequestBuilder {
    func send<T: ResponseDecoder>(_ decoder: T.Type, data: UploadData? = nil, progress: ((Progress) -> Void)? = nil, completion: CallResponse<T>) {
        if let data = data {
            uploadToServerWith(decoder, data: data, request: self, parameters: self.parameters, progress: progress, completion: completion)
        } else {
            AF.request(self).validate().responseData { (response) in
                self.handleResponse(response, completion: completion)
            }
        }
    }
}
