////
////  APISession.swift
////  ScoreBoard
////
////  Created by Edu Calero on 18/08/2020.
////  Copyright © 2020 Iflet.tech. All rights reserved.
////
//
//import Alamofire
//import Combine
//import UIKit
//
//
//enum APIError: Error {
//    case decodingError(String?)
//    case httpError(Int)
//    case unknown
//}
//
//
///// Defines the various types of authentication types.
/////
///// - basic:    Defines a `basic` authentication that sends an authorization header with a token like `Basic XXXXXXX`.
///// - bearer:   Defines a `bearer` authentication that sends an authorization header with a token like `Bearer XXXXXXX`.
///// - oauth2:   Defines an `OAuth2` authentication. Pending implementation.
///// - none:     Defines no authentication and discard authentication token.
//enum AuthenticationType {
//    case basic
//    case bearer
//    case oauth2
//    case rapidAPIKey
//    case none
//}
//
//struct APISession {
//    
//    /// Starts the download requests inmediately. By default you can perform download requests on demand. It defaults to `false`.
//    var startDownloadRequestsImmediately = false
//    
//    /// Sets the authentication method for the requests. It defaults to `none`.
//    var authenticationType: AuthenticationType = .bearer
//    
//    /// The timeout interval for all requests within the session. It defaults to `30 seconds`.
//    var timeoutInterval: TimeInterval = 30
//    
//    /// Set this to `true` if you want Alamofire looks for the certificates in the app bundle. It defaults to `false`.
//    var usePinnedCertificates = false
//    
//    /// Validates the host name against the first certificate in the certificate chain if `validateCertificateChain` is `true`. It defaults to `false`.
//    var validateHost = false
//    
//    /// Validates the certificate chain.
//    var validateCertificateChain = true
//    
//    /// A `Dictionary` to specify custom additional headers to be sent with the requests.
//    var headers = [String : String]()
//    
//    
//   
//    
//    func sessionManager(with configuration: URLSessionConfiguration) -> SessionManager {
//        let instance: SessionManager
//        
//        var headers = Alamofire.SessionManager.defaultHTTPHeaders
//        API.manager.headers.forEach { headers[$0] = $1 }
//        configuration.httpAdditionalHeaders = headers
//        configuration.timeoutIntervalForRequest = API.manager.timeoutInterval
//        
//        if API.manager.usePinnedCertificates {
//            let certificates = ServerTrustPolicy.certificates(in: Bundle.main)
//            let serverTrustPolicy = ServerTrustPolicy.pinCertificates(
//                certificates: certificates,
//                validateCertificateChain: API.manager.validateCertificateChain,
//                validateHost: API.manager.validateHost
//            )
//            
//            let serverTrustPolicies = [Path.BaseURL : serverTrustPolicy]
//            let serverTrustPolicyManager = ServerTrustPolicyManager(policies: serverTrustPolicies)
//            
//            instance = Alamofire.SessionManager(configuration: configuration, serverTrustPolicyManager: serverTrustPolicyManager)
//        } else {
//            instance = Alamofire.SessionManager(configuration: configuration)
//        }
//        
//        instance.startRequestsImmediately = false
//        return instance
//    }
//    
//}
//
//
//extension APISession {
//    
//    
//    
//    func request<T>(with builder: RequestBuilder) -> AnyPublisher<T, APIError> where T: Decodable {
//        
////        let decoder = JSONDecoder()
////        decoder.keyDecodingStrategy = .convertFromSnakeCase
//        
//         return URLSession.shared
//            .dataTaskPublisher(for: builder.urlRequest)
//            //            .debounce(for: .seconds(1), scheduler: RunLoop.main)
//            .receive(on: DispatchQueue.main)
//            .mapError { error in
//                print("URLSession DatataskpublisherError: \(error.localizedDescription)")
//                return .unknown }
//            .flatMap { data, response -> AnyPublisher<T, APIError> in
//                if let response = response as? HTTPURLResponse {
//                    if (200...299).contains(response.statusCode) {
//                    
//                    return Just(data)
//                        .decode(type: T.self, decoder: JSONDecoder())
//                        .mapError {error -> APIError in .decodingError(error.localizedDescription)}
//                        .eraseToAnyPublisher()
//                    } else {
//                        return Fail(error: APIError.httpError(response.statusCode))
//                            .eraseToAnyPublisher()
//                    }
//                }
//                return Fail(error: APIError.unknown)
//                        .eraseToAnyPublisher()
//            }
//            .eraseToAnyPublisher()
//    }
//
//    func requestImage(with url: String) -> AnyPublisher<UIImage, APIError> {
//        guard let url = URL(string: url)
//            else {
//                return Fail(error: .decodingError(nil))
//                    .eraseToAnyPublisher()
//        }
//        
//        return URLSession.shared.dataTaskPublisher(for: url)
//            .receive(on: DispatchQueue.main)
//            .mapError { _ in .unknown }
//            .flatMap { data, response -> AnyPublisher<UIImage, APIError> in
//                if let image = UIImage(data: data) {
//                    return Just(image)
//                        .mapError {error -> APIError in .decodingError(error.localizedDescription) }
//                        .eraseToAnyPublisher()
//                }
//                return Fail(error: .unknown)
//                    .eraseToAnyPublisher()
//            }
//            .eraseToAnyPublisher()
//        
//    }
//}
