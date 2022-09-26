//
//  SeasonModelLogic.swift
//  ScoreBoard
//
//  Created by Eduard Calero on 24/9/22.
//  Copyright © 2022 Iflet.tech. All rights reserved.
//

import Foundation
import RealmSwift

var currentSeasson = ""


enum ModelLogicError: Error, LocalizedError {
    
    case notCurrenSeassonFound
}

final class SeasonModelLogic {
    
    static let shared = SeasonModelLogic()
    let realm = try! Realm()
   
    
    private init(){}
    
    func loadFromBackend() async throws {
        
        let response = await RestManager.manager.requestObject(ErgastAPI.seasson(), responseType: Seasons.self)
        
        switch response.result {
        case .success(let currentSeasonJSON):
            
            guard let currentSeassonString = currentSeasonJSON.data.seasonTable.seasons.first?.season,
                  !currentSeassonString.isEmpty else {
                throw ModelLogicError.notCurrenSeassonFound
            }
            
            if let _ = realm.object(ofType: SeassonsRealmModel.self, forPrimaryKey: currentSeassonString) {
                    //Nothing to do because the model only has one key that is the model itself.
            } else {
                let currentSeassonRealmModel = SeassonsRealmModel(season: currentSeassonString)
                try realm.write({
                    realm.add(currentSeassonRealmModel, update: .all)
                })

            }
            
            currentSeasson = currentSeassonString
            
            
        case .failure(let error):
            throw error
        }
    }
    
}
