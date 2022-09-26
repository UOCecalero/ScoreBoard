//
//  PlayerAPIProtocols.swift
//  ScoreBoard
//
//  Created by Edu Calero on 18/08/2020.
//  Copyright © 2020 Iflet.tech. All rights reserved.
//


import UIKit
import Alamofire
import Combine

final class RestManager {
    
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
    
    
    fileprivate var session: Alamofire.Session!
    
    static let manager = RestManager()
    
    private init(){
        
        sessionConfiguration.timeoutIntervalForRequest = timeoutInterval
        sessionConfiguration.httpAdditionalHeaders = headers
        
        session =  Alamofire.Session(configuration: sessionConfiguration,
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
    
    
    func reloadSession(){
        
        sessionConfiguration.timeoutIntervalForRequest = timeoutInterval
        sessionConfiguration.httpAdditionalHeaders = headers
        
        session =  Alamofire.Session(configuration: sessionConfiguration,
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
    
    /// Cancels all the pending tasks for the current session. It cancels all data, upload and download tasks.
    func cancelAll() {
        session?.cancelAllRequests()
    }
}


extension RestManager {
    
    //MARK: - Async/Await
    func requestObject<T: Decodable>(_ endpoint: RequestBuilderProtocol, responseType: T.Type) async -> (DataResponse<T, AFError>)  {
        
                print("\n \nHEADERS: ******")
                endpoint.headers?.forEach{ print($0) }
                print("ENDHEADERS ******")
        
                print("API CALL ******")
                print("\(endpoint.method.rawValue) \(endpoint.baseURLString)\(endpoint.path)")
                endpoint.parameters?.forEach{ print($0) }
                print("END API CALL ****** \n \n")
        
             let afTask =   session.request(endpoint,
                                      method: endpoint.method,
                                      parameters: endpoint.parameters,
                                      encoding: endpoint.encoding,
                                      headers: endpoint.headers,
                                      interceptor: endpoint.interceptor,
                                      requestModifier: endpoint.requestModifiyer)
            .serializingDecodable(T.self)
        
                let response = await afTask.response
                print("\n \nAPI CALL RESPONSE ******")
                debugPrint(response)
                print("END API CALL RESPONSE ******\n \n")
//                    if  response.response?.statusCode == 401 {
//                        print("SESSION EXPIRED  ******\n \n")
//                        NotificationCenter.default.post(name: .didSessionExpire, object: nil)
//                    }
        
            return response

        }
    
    
        //MARK: - Combine
    func request<T: Decodable>(with builder: RequestBuilderProtocol) -> AnyPublisher<T, RestCombineError>  {
    
    //        let decoder = JSONDecoder()
    //        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let urlRequest = builder.urlRequest else {
            return Fail(error: RestCombineError.unknown)
                    .eraseToAnyPublisher()
        }
    
             return URLSession.shared
            .dataTaskPublisher(for: urlRequest)
                //            .debounce(for: .seconds(1), scheduler: RunLoop.main)
                .receive(on: DispatchQueue.main)
                .mapError { error in
                    print("URLSession DatataskpublisherError: \(error.localizedDescription)")
                    return .unknown
                }
                .flatMap { data, response -> AnyPublisher<T, RestCombineError> in
                    if let response = response as? HTTPURLResponse {
                        if (200...299).contains(response.statusCode) {
    
                        return Just(data)
                            .decode(type: T.self, decoder: JSONDecoder())
                            .mapError {error -> RestCombineError in .decodingError(error.localizedDescription)}
                            .eraseToAnyPublisher()
                        } else {
                            return Fail(error: RestCombineError.httpError(response.statusCode))
                                .eraseToAnyPublisher()
                        }
                    }
                    return Fail(error: RestCombineError.unknown)
                            .eraseToAnyPublisher()
                }
                .eraseToAnyPublisher()
        }
    
        func requestImage(with url: String) -> AnyPublisher<UIImage, RestCombineError> {
            guard let url = URL(string: url)
                else {
                    return Fail(error: .decodingError(nil))
                        .eraseToAnyPublisher()
            }
    
            return URLSession.shared.dataTaskPublisher(for: url)
                .receive(on: DispatchQueue.main)
                .mapError { _ in .unknown }
                .flatMap { data, response -> AnyPublisher<UIImage, RestCombineError> in
                    if let image = UIImage(data: data) {
                        return Just(image)
                            .mapError { error -> RestCombineError in .decodingError(error.localizedDescription) }
                            .eraseToAnyPublisher()
                    }
                    return Fail(error: .unknown)
                        .eraseToAnyPublisher()
                }
                .eraseToAnyPublisher()
    
        }
}






