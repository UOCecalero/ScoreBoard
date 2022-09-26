//
//  DriversModelLogic.swift
//  ScoreBoard
//
//  Created by Eduard Calero on 24/9/22.
//  Copyright © 2022 Iflet.tech. All rights reserved.
//

import Foundation
import RealmSwift

final class DriversModelLogic {
    
    static let shared = DriversModelLogic()
    
    private init(){}
    
    func loadFromBackend() async throws {
        
        guard !currentSeasson.isEmpty,
                let currentSeassonInt = Int(currentSeasson) else {
            throw RacesModelLogicError.invalidCurrentSeasson
        }
        
        let realm = try! await Realm()
        
        let teams = Array(realm.objects(ConstructorsRealmModel.self).where({  $0.seassonId == currentSeasson }))
    
        
        for team in teams {
             await withThrowingTaskGroup(of: Void.self) { group in
                group.addTask(priority: .userInitiated) {
                    try await self.updateConstructorForTeam( currentSeassonInt, team: team)
                }
            }
        }
    }
    
    
    fileprivate func updateConstructorForTeam(_ currentSeassonInt: Int, team: ConstructorsRealmModel) async throws {
        let response = await RestManager.manager.requestObject(ErgastAPI.drivers(currentSeassonInt, team: team.constructorId), responseType: Drivers.self)

        switch response.result {
        case .success(let diriversJSON):

            guard !currentSeasson.isEmpty else {
                throw ModelLogicError.notCurrenSeassonFound
            }
            
            let realm = try! await Realm()

            //Save or update ConstructorsRealmModel
            try diriversJSON.data.driverTable.drivers.forEach {

                    let constructorRealmModel = DriversRealmModel(seasson: currentSeasson,
                                                                  constructorId: team.constructorId,
                                                                  driverId: $0.driverId,
                                                                  url: $0.url,
                                                                  givenName: $0.givenName,
                                                                  familyName: $0.familyName,
                                                                  dateOfBirth: $0.dateOfBirth,
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
