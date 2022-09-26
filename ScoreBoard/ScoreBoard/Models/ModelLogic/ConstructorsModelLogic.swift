//
//  ConstructorsModelLogic.swift
//  ScoreBoard
//
//  Created by Eduard Calero on 24/9/22.
//  Copyright © 2022 Iflet.tech. All rights reserved.
//

import Foundation
import RealmSwift

final class ConstructorsModelLogic {
    
    static let shared = ConstructorsModelLogic()
    
    let realm = try! Realm()
    
    private init(){}
    
    func loadFromBackend() async throws {
        
        guard let currentSeassonInt = Int(currentSeasson) else {
            throw RacesModelLogicError.invalidCurrentSeasson
        }

        
        let response = await RestManager.manager.requestObject(ErgastAPI.constructors(currentSeassonInt), responseType: Constructors.self)
        
        switch response.result {
        case .success(let constructorsJSON):
            
            guard !currentSeasson.isEmpty else {
                throw ModelLogicError.notCurrenSeassonFound
            }
            
            let realm = try! await Realm()
            
            //Save or update ConstructorsRealmModel
            try constructorsJSON.data.constructorTable.constructors.forEach {
                
                    let constructorRealmModel = ConstructorsRealmModel(seasson: currentSeasson,
                                                                      constructorId: $0.constructorId,
                                                                      url: $0.url,
                                                                      name: $0.name,
                                                                      nationality: $0.nationality)
                    try realm.write({
                        realm.add(constructorRealmModel, update: .modified)
                    })

                }
            
            
        case .failure(let error):
            throw error
        }
         
        
    }
    
}
