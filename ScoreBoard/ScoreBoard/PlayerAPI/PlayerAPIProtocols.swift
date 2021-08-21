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
    func getPlayer(playerID: Int) -> AnyPublisher<Player, APIError>
    func getPlayerImage(from url: String) -> AnyPublisher<UIImage, APIError>
}

extension PlayerService {
    
    func getPlayerList(playerName: String) -> AnyPublisher<SMPlayerSearchResponseModel, APIError> {
        return apiSession.request(with: PlayerEndpoint.sportMonksPlayerSearchByName(playerName))
            .eraseToAnyPublisher()
    }
    
    func getPlayer(playerID: Int) -> AnyPublisher<Player, APIError> {
        return apiSession.request(with: PlayerEndpoint.playerDetail(playerID))
            .eraseToAnyPublisher()
    }
    
    func getPlayerImage(from url: String) -> AnyPublisher<UIImage, APIError>{
        return apiSession.requestImage(with: url)
                .eraseToAnyPublisher()
    }
}
