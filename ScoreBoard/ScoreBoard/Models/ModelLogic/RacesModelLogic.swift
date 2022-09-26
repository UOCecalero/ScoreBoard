//
//  RacesModelLogic.swift
//  ScoreBoard
//
//  Created by Eduard Calero on 24/9/22.
//  Copyright © 2022 Iflet.tech. All rights reserved.
//

import Foundation
import RealmSwift

enum RacesModelLogicError: Error, LocalizedError {
    
    case invalidCurrentSeasson
}

final class RacesModelLogic {
    
    static let shared = RacesModelLogic()
    
    private init(){}
    
    func loadFromBackend() async throws {
        
        guard let currentSeassonInt = Int(currentSeasson) else {
            throw RacesModelLogicError.invalidCurrentSeasson
        }
        
        
            let response = await RestManager.manager.requestObject(ErgastAPI.raceResults(currentSeassonInt), responseType: RaceSchedule.self)
            switch response.result {
            case .success(let racesJSON):

                let realm = try! await Realm()
                
                //Save or update RacesRealmModel
                try racesJSON.data.raceTable.races.forEach {
                    
                    let raceRealmModel = RacesRealmModel(seasson: $0.season,
                                                                round: $0.round,
                                                                url: $0.url,
                                                                raceName: $0.raceName,
                                                                circuit: $0.circuit,
                                                                date: $0.date,
                                                                time: $0.time)
                        try realm.write({
                            realm.add(raceRealmModel, update: .modified)
                        })

                    }
                
                
            case .failure(let error):
                throw error
            }
        }
    
}
