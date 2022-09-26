//
//  PlayerEndpoint.swift
//  ScoreBoard
//
//  Created by Edu Calero on 18/08/2020.
//  Copyright © 2020 Iflet.tech. All rights reserved.
//

import Foundation
import Alamofire

enum Endpoints {
    case apiSportsPlayerSearchByName(String)
    case sportMonksPlayerSearchByName(String)
    case playerSeasons(Int)
    case playerDetail(Int)
}

extension Endpoints: RequestBuilderProtocol {
    

    
    func asURL() throws -> URL {
        guard let url = URL(string: self.baseURLString + self.path)
        else { preconditionFailure("Invalid URL format") }
        return url
    }

    
    var method: HTTPMethod {
        switch self {
        default: return .get
        }
    }
    
    var encoding: URLEncoding {
        switch self {
        default: return URLEncoding.default
        }
    }
    
    var path: String {
        switch self {
        case .apiSportsPlayerSearchByName(let name):    return "players/search/\(name)"
        case .sportMonksPlayerSearchByName(let name):   return "players/search/\(name)"
        case .playerSeasons:                            return "Holy sheet" //TODO: Falta modificar
        case .playerDetail:                             return "Holy sheet" //TODO: Falta modificar
        }
    }
    
    var parameters: Parameters? {
        switch self {
            
        case .apiSportsPlayerSearchByName(_):
            return [ "X-RapidAPI-Key" : "f60eaf4700037d9e7c27b7ea13edb4ca" ]
            
        case .sportMonksPlayerSearchByName(_):
            return ["api_token" : "6s4A6zpHOZowMmvuHxYRvmkGF5NY5gSuNQLcCTK2xoNwNAXfm75i6L1n6jgl"]
            
        default: return nil
        }
    }
    
    var headers: HTTPHeaders? {
        switch self{
        default: return nil
        }
    }
    
    var baseURLString: String {
        switch self {
        case .apiSportsPlayerSearchByName:
            return "https://v2.api-football.com/"
        case .sportMonksPlayerSearchByName, .playerSeasons, .playerDetail:
            return "https://soccer.sportmonks.com/api/v2.0/"
        }
    }
    
    var interceptor: RequestInterceptor? {
        switch self {
        default: return nil
        }
    }
    
    
    var requestModifiyer: ((inout URLRequest) throws -> Void)? {
        switch self {
            default: return nil
        }
    }
    
    var requiresAuthorization: Bool {
        switch self {
        default: return true
        }
    }
    
}
