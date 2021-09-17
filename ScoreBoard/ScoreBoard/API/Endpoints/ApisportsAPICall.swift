//
//  ApisportsAPICall.swift
//  ScoreBoard
//
//  Created by Eduard Calero on 27/6/21.
//  Copyright © 2021 Iflet.tech. All rights reserved.
//

//import Foundation
//import Alamofire
//
//enum apisSportosAPIEndpoint {
//    case searchPlayerBy(name: String)
////    case playerSeasons(Int)
////    case playerDetail(Int)
//}
//
//
//
//struct ApisportsAPICall: AlamofireAPICallProtocol {
//    
//    
//    init(withEndpont endpoint: apisSportosAPIEndpoint, version: Int = 2) {
//        self.endpoint = endpoint
//        self.version  = version
//    }
//    
//    let version: Int!
//    var baseURL: String { "https://v\(version).api-football.com/" }
//    
//    private var endpoint: apisSportosAPIEndpoint
//    
//    var urlRequest: String {
//        switch endpoint {
//        case .searchPlayerBy(let name):         return "players/search/\(name)"
//        }
//    }
//    
//    var method: HTTPMethod {
//        switch endpoint {
//        case .searchPlayerBy:                         return .get
//        }
//            
//    }
//    
//    var params: [String : Any]? {
//        switch endpoint {
//        default:
//            return nil
//        }
//    }
//    var encoding: ParameterEncoding? {
//        switch endpoint {
//        case .searchPlayerBy:
//            return URLEncoding.default
//        default:
//            return JSONEncoding.default
//        }
//    }
//        
//    var requiresAuthorization: AuthenticationType {
//        return .rapidAPIKey
//    }
//    
//    
//}
