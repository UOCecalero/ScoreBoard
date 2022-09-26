//
//  RequestBuilderProtocol.swift
//  ScoreBoard
//
//  Created by Eduard Calero on 22/7/21.
//  Copyright © 2021 Iflet.tech. All rights reserved.
//

import Foundation
import Alamofire

protocol RequestBuilderProtocol: URLConvertible, URLRequestConvertible{
    
    var method: Alamofire.HTTPMethod                                    { get }
    var encoding: Alamofire.URLEncoding                                 { get }
    var baseURLString: String                                           { get }
    var path: String                                                    { get }
    var headers: Alamofire.HTTPHeaders?                                 { get }
    var parameters: [String: Any]?                                      { get }
    var interceptor: Alamofire.RequestInterceptor?                      { get }
    var requestModifiyer: Session.RequestModifier?                      { get }
    var requiresAuthorization: Bool                                     { get }
}


//MARK: URLConvertible
extension RequestBuilderProtocol {
    func asURL() throws -> URL {
        guard let url = URL(string: self.baseURLString + self.path)
        else { preconditionFailure("Invalid URL format") }
        return url
    }
}

//MARK: URLRequestConvertible
extension RequestBuilderProtocol {
    func asURLRequest() throws -> URLRequest {
        
        var request = URLRequest(url: try asURL())
        request.method = self.method
        request.headers = self.headers ?? []
//        request.timeoutInterval = timeout
//        request.cachePolicy = cachePolicy

        return request
    }
}
