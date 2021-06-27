//
//  SportsMonksAPICall.swift
//  ScoreBoard
//
//  Created by Eduard Calero on 27/6/21.
//  Copyright © 2021 Iflet.tech. All rights reserved.
//

import Foundation
import Alamofire

enum sportsMonksAPIEndpoint {
    case searchPlayer(name: String)
}


struct SportsMonksAPICall: AlamofireAPICallProtocol {

    init(withEndpont endpoint: sportsMonksAPIEndpoint, version: Int = 2) {
        self.endpoint = endpoint
        self.version = version
    }
    
    let version: Int!
    var baseURL: String { "https://soccer.sportmonks.com/api/v\(version).0/" }
    
    private var endpoint: sportsMonksAPIEndpoint
    
    var urlRequest: String {
        switch endpoint {
        case .searchPlayer(let name):               return "players/search/\(name)"
        }
    }
    var method: HTTPMethod {
        switch endpoint {
        case .searchPlayer:                         return .get
        }
            
    }
    
    var params: [String : Any]? {
        switch endpoint {
        case .searchPlayer:             return ["api_token" : "6s4A6zpHOZowMmvuHxYRvmkGF5NY5gSuNQLcCTK2xoNwNAXfm75i6L1n6jgl"]
        default:
            return nil
        }
    }
    var encoding: ParameterEncoding? {
        switch endpoint {
        case .searchPlayer:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
        
        
    var requiresAuthorization: AuthenticationType {
        return .none
    }
    
}
