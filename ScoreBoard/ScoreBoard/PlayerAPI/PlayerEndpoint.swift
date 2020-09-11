//
//  PlayerEndpoint.swift
//  ScoreBoard
//
//  Created by Edu Calero on 18/08/2020.
//  Copyright © 2020 Iflet.tech. All rights reserved.
//

import Foundation

enum PlayerEndpoint {
    case apiSportsPlayerSearchByName
    case sportMonksPlayerSearchByName(String)
    case playerSeasons(Int)
    case playerDetail(Int)
}

extension PlayerEndpoint: RequestBuilder {
    
    var urlRequest: URLRequest {
        switch self {
        case .apiSportsPlayerSearchByName:
            guard let url = URL(string: "https://v2.api-football.com/players/search/Messi")
                else {preconditionFailure("Invalid URL format")}
            var request = URLRequest(url: url)
            request.allHTTPHeaderFields = [
                "X-RapidAPI-Key" : "f60eaf4700037d9e7c27b7ea13edb4ca"
            ]
            return request
            
        case .sportMonksPlayerSearchByName(let name):
        guard let url = URL(string: "https://soccer.sportmonks.com/api/v2.0/players/search/\(name)?api_token=6s4A6zpHOZowMmvuHxYRvmkGF5NY5gSuNQLcCTK2xoNwNAXfm75i6L1n6jgl")        else { preconditionFailure("Invalid URL format") }
        let request = URLRequest(url: url)
        return request
            
        case .playerSeasons(let playerID):
            guard let url = URL(string: "playerID") //Hay que modificar la URL para añadir
            else { preconditionFailure("Invalid URL format") }

            let request = URLRequest(url: url)
            return request
            
            
        case .playerDetail(let playerID):
            guard let url = URL(string: "playerID") //Hay que modificar la URL para añadir
                else {preconditionFailure("Invalid URL format")}

            let request = URLRequest(url: url)
            return request
            break
        }
        
    }
}
