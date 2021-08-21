//
//  PlayerListViewModel.swift
//  ScoreBoard
//
//  Created by Edu Calero on 18/08/2020.
//  Copyright © 2020 Iflet.tech. All rights reserved.
//

import UIKit
import Combine


class PlayerListViewModel: ObservableObject, PlayerService {
    
    @Published var players = [SMPlayer]()
    @Published var images = [UIImage]()
    @Published var playerName = "" {
        didSet{
            getPlayerList()
            print(playerName)
        }
    }
    
    var apiSession: APIService
    var cancellables = Set<AnyCancellable>()
    
    init(apiSession: APIService = APISession()) {
        self.apiSession = apiSession
    }
    
    func getPlayerList() {
        let cancellable = self.getPlayerList(playerName: playerName.trimmingCharacters(in: .whitespacesAndNewlines))
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    switch error {
                    case .decodingError(let description):
                         print("Handle error: DecodingError -> \(description ?? "") ")
                        break
                    case .httpError(let errorNumber):
                        print("Handle error: httpError -> \(errorNumber) ")
                        break
                    default:
                         print("Handle error: \(error) ")
                    }
                   
                case .finished:
                    break
                }
                
            }) { (response) in
                self.players = response.data ?? []
                self.getPlayersImage()
                
        }
        cancellables.insert(cancellable)
    }
    
    func getPlayersImage(){
        players.forEach{ player in
            guard let imagePath = player.imagePath else {return}
            
            self.getPlayerImage(from: imagePath)
                .sink(receiveCompletion: { result in
                    switch result {
                    case .failure(let error):
                        switch error {
                        case .decodingError(let description):
                             print("Handle error: DecodingError -> \(description ?? "") ")
                            break
                        case .httpError(let errorNumber):
                            print("Handle error: httpError -> \(errorNumber) ")
                            break
                        default:
                             print("Handle error: \(error) ")
                        }
                       
                    case .finished:
                        break
                    }
                }){ response in
                }
        }
    }
    
    func getPlayerImage(from url: String) -> AnyPublisher<UIImage, APIError> {
        return apiSession.requestImage(with: url)
    }

}
