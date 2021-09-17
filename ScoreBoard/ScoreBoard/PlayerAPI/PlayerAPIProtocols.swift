//
//  PlayerAPIProtocols.swift
//  ScoreBoard
//
//  Created by Edu Calero on 18/08/2020.
//  Copyright © 2020 Iflet.tech. All rights reserved.
//

import Combine
import Alamofire
import Foundation
import Combine

enum SharedAPIError: Error, LocalizedError {
    
    case endpointURLError
    
    
    var errorDescription: String {
        switch self {
        case .endpointURLError: return "Endpoint URL can't be retreived"
        }
    }
    
}


final class SharedAPI {
    
    /// Defines the various types of authentication types.
    ///
    /// - basic:    Defines a `basic` authentication that sends an authorization header with a token like `Basic XXXXXXX`.
    /// - bearer:   Defines a `bearer` authentication that sends an authorization header with a token like `Bearer XXXXXXX`.
    /// - oauth2:   Defines an `OAuth2` authentication. Pending implementation.
    /// - none:     Defines no authentication and discard authentication token.
    enum AuthenticationType {
        case basic
        case bearer
        case oauth2
        case none
    }
    
    
    fileprivate var foregroundSession: Alamofire.Session!
    fileprivate var backgroundSession: Alamofire.Session!
    
    static let manager = SharedAPI()
    
    private init(){
        reloadSessions()
    }
    
    var sessionConfiguration = URLSessionConfiguration.af.default
    var sessionDelegate = SessionDelegate()
    var rootQueue: DispatchQueue = DispatchQueue(label: "org.alamofire.session.rootQueue")
    var startRequestsImmediately: Bool = true
    var requestQueue: DispatchQueue? = nil
    var serializationQueue: DispatchQueue? = nil
    var interceptor: RequestInterceptor? = nil
    var serverTrustManager: ServerTrustManager? = nil
    var redirectHandler: RedirectHandler? = nil
    var cachedResponseHandler: CachedResponseHandler? = nil
    var eventMonitors: [EventMonitor] = []
    var authenticationType: AuthenticationType = .none
    var timeoutInterval: TimeInterval = 30
    var headers = [String : String]()
    var sessionConfiguretionIdentifiyer = "tech.iflet.___PROJECTNAME___"
    
    
    func reloadForegroundSession(){
        
        sessionConfiguration.timeoutIntervalForRequest = timeoutInterval
        sessionConfiguration.httpAdditionalHeaders = headers
        
        foregroundSession =  Alamofire.Session(configuration: sessionConfiguration,
                                               delegate: sessionDelegate,
                                               rootQueue: rootQueue,
                                               startRequestsImmediately: startRequestsImmediately,
                                               requestQueue: requestQueue,
                                               serializationQueue: serializationQueue,
                                               interceptor: interceptor,
                                               serverTrustManager: serverTrustManager,
                                               redirectHandler: redirectHandler,
                                               cachedResponseHandler: cachedResponseHandler,
                                               eventMonitors: eventMonitors)
        
    }
    
    func reloadBackgroundSession(){
        
        let backGroundDefaultSession = URLSessionConfiguration.background(withIdentifier: sessionConfiguretionIdentifiyer)
        backGroundDefaultSession.timeoutIntervalForRequest = timeoutInterval
        backGroundDefaultSession.httpAdditionalHeaders = headers
        
        
        backgroundSession =  Alamofire.Session(configuration: backGroundDefaultSession,
                                               delegate: sessionDelegate,
                                               rootQueue: rootQueue,
                                               startRequestsImmediately: startRequestsImmediately,
                                               requestQueue: requestQueue,
                                               serializationQueue: serializationQueue,
                                               interceptor: interceptor,
                                               serverTrustManager: serverTrustManager,
                                               redirectHandler: redirectHandler,
                                               cachedResponseHandler: cachedResponseHandler,
                                               eventMonitors: eventMonitors)
        
    }
    
    func reloadSessions() {
        
        reloadForegroundSession()
        reloadForegroundSession()
    }
    
    /// Cancels all the pending tasks for the current session. It cancels all data, upload and download tasks.
    func cancelAll() {
        foregroundSession?.cancelAllRequests()
        backgroundSession?.cancelAllRequests()
    }
    
    func cancelForegrounds(){
        foregroundSession?.cancelAllRequests()
    }
    func cancelBackgrounds(){
        backgroundSession?.cancelAllRequests()
    }
}


extension SharedAPI {
    func requestObject<T: Decodable>(_ endpoint: RequestBuilderProtocol, completion: @escaping ( (DataResponse<T, AFError>)->()) )  {
        
        
        
        foregroundSession.request(endpoint,
                                  method: endpoint.method,
                                  parameters: endpoint.parameters,
                                  encoding: endpoint.encoding,
                                  headers: endpoint.headers,
                                  interceptor: endpoint.interceptor,
                                  requestModifier: endpoint.requestModifiyer)
            .responseDecodable { completion($0) }

        }
    
   
    func requestObjectPublisher<T: Decodable>(_ endpoint: RequestBuilderProtocol, responseType: T.Type) -> AnyPublisher<T, AFError> {

        
                return foregroundSession.request(endpoint,
                                          method: endpoint.method,
                                          parameters: endpoint.parameters,
                                          encoding: endpoint.encoding,
                                          headers: endpoint.headers,
                                          interceptor: endpoint.interceptor,
                                          requestModifier: endpoint.requestModifiyer)
                    .publishDecodable(type: T.self)
                    .value()
    }
}






