//
//  PlayerListViewModel.swift
//  ScoreBoard
//
//  Created by Edu Calero on 18/08/2020.
//  Copyright © 2020 Iflet.tech. All rights reserved.
//

import Foundation
import Combine


//protocol PlayerService {
//    var apiSession: APIService {get}
//
//    func getPlayerList(playerName: String) -> AnyPublisher<SMPlayerSearchResponseModel, APIError>
//    //func getPlayer(playerURL: String) -> AnyPublisher<Player, APIError>
//}
//
//extension PlayerService {
//
//    func getPlayerList(playerName: String) -> AnyPublisher<SMPlayerSearchResponseModel, APIError> {
//        return apiSession.request(with: PlayerEndpoint.sportMonksPlayerSearchByName(playerName))
//            .eraseToAnyPublisher()
//    }
//
////    func getPlayer(platerURL: String) -> AnyPublisher<Player, APIError> {
////        return apiSession.request(with: PlayerEndpoint.playerDetail(playerURL))
////            .eraseToAnyPublisher()
////    }
//}

class PlayerListViewModel: ObservableObject {
    
    @Published var players = [SMPlayer]()
    @Published var playerName = "" {
        didSet{
            getPlayerList()
            print(playerName)
        }
    }
    
    var apiSession: SharedAPI?
    var subcriptions = Set<AnyCancellable>()
    
    init(apiSession: SharedAPI = .manager) {
        self.apiSession = apiSession
    }
    
    func getPlayerList() {
        let cancellable = apiSession?.requestObjectPublisher(Endpoints
                                                                .sportMonksPlayerSearchByName(playerName
                                                                                                .replacingOccurrences(of: " ", with: "")
                                                                                                .trimmingCharacters(in: .whitespacesAndNewlines)),
                                                             responseType: SMPlayerSearchResponseModel.self)
            
            .retry(3)
            .compactMap { $0.data }
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    //TODO: Error handling
                    debugPrint(error)
                }
            }, receiveValue: { players in
                self.players = players
            })
            .store(in: &subcriptions)
    }
}
