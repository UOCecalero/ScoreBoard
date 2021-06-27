//
//  APIProtocols.swift
//  ScoreBoard
//
//  Created by Edu Calero on 18/08/2020.
//  Copyright © 2020 Iflet.tech. All rights reserved.
//

import UIKit
import Combine
import Alamofire

protocol APIProtocol {
    
    var session: Alamofire.Session                  {get}
//    var startDownloadRequestsImmediately: Bool      {get}
//    var authenticationType: AuthenticationType      {get}
//    var timeoutInterval: TimeInterval               {get}
//    var usePinnedCertificates: Bool                 {get}
//    var validateHost: Bool                          {get}
//    var validateCertificateChain: Bool              {get}
//    var headers: [String : Any]                     {get}
    
    
    func request<T: Decodable>(with call: AlamofireAPICallProtocol) -> AnyPublisher<T, APIError>
    func requestImage(with url: String) -> AnyPublisher<UIImage, APIError>
}

//extension APIServiceProtocol {
//
//    func getDefaultSessionManager() -> Alamofire.Session {
//        let configuration = URLSessionConfiguration.default
//        return API.manager.sessionManager(with: configuration)
//    }
//
//    let gatBackgroundSessionManager -> Alamofire.SessionManager {
//        let configuration = URLSessionConfiguration.background(withIdentifier: sessionConfigurationIdentifier)
//        return API.manager.sessionManager(with: configuration)
//    }
//
//}

// TODO: Implementación de API que conforma APIProtocol

protocol AlamofireAPICallProtocol {
    
    var baseURL: String                             {get}
    var urlRequest: String                          {get}
    var method: Alamofire.HTTPMethod                {get}
    var params: [String : Any]?                     {get}
    var encoding: Alamofire.ParameterEncoding?      {get}
    var requiresAuthorization: AuthenticationType   {get}
}
