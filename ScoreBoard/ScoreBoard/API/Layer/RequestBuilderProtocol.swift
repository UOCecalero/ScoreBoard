//
//  RequestBuilderProtocol.swift
//  ScoreBoard
//
//  Created by Eduard Calero on 22/7/21.
//  Copyright © 2021 Iflet.tech. All rights reserved.
//

import Alamofire

protocol RequestBuilderProtocol: URLConvertible {
    
    var method: Alamofire.HTTPMethod                                    { get }
    var encoding: Alamofire.URLEncoding                                 { get }
    var path: String                                                    { get }
    var headers: Alamofire.HTTPHeaders?                                 { get }
    var parameters: [String: Any]?                                      { get }
    var interceptor: Alamofire.RequestInterceptor?                      { get }
    var baseURLString: String                                           { get }
    var requestModifiyer: ((inout URLRequest) throws -> Void)?          { get }
    var requiresAuthorization: Bool                                     { get }
}
