//
//  PlayerAPIProtocols.swift
//  ScoreBoard
//
//  Created by Edu Calero on 18/08/2020.
//  Copyright © 2020 Iflet.tech. All rights reserved.
//

import Combine
import UIKit

protocol PlayerService {
    var apiSession: APIService {get}
    
    func getPlayerList(playerName: String) -> AnyPublisher<SMPlayerSearchResponseModel, APIError>
    //func getPlayer(playerURL: String) -> AnyPublisher<Player, APIError>
}

extension PlayerService {
    
    func getPlayerList(playerName: String) -> AnyPublisher<SMPlayerSearchResponseModel, APIError> {
        return apiSession.request(with: PlayerEndpoint.sportMonksPlayerSearchByName(playerName))
            .eraseToAnyPublisher()
    }
    
//    func getPlayer(platerURL: String) -> AnyPublisher<Player, APIError> {
//        return apiSession.request(with: PlayerEndpoint.playerDetail(playerURL))
//            .eraseToAnyPublisher()
//    }
}
