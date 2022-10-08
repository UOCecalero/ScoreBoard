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
    
    let context = PersistenceController.shared.persistentCloudContainer.viewContext
    
    private init(){}
    
    func loadFromBackend() async throws {
        
        guard !currentSeasson.isEmpty,
                let currentSeassonInt = Int(currentSeasson) else {
            throw RacesModelLogicError.invalidCurrentSeasson
        }
        
        let teamsFetchRequest = ConstructorsCDM.fetchRequest()
        teamsFetchRequest.predicate = NSPredicate(format: "%K = %@", #keyPath(ConstructorsCDM.seassonId), currentSeasson)
        
        let constructorsFetchResponse = try context.fetch(teamsFetchRequest)
        
        for constructor in constructorsFetchResponse {
             await withThrowingTaskGroup(of: Void.self) { group in
                group.addTask(priority: .userInitiated) {
                    try await self.updateConstructorForTeam( currentSeassonInt, team: constructor)
                }
            }
        }
    }
    
    
    fileprivate func updateConstructorForTeam(_ currentSeassonInt: Int, team: ConstructorsCDM) async throws {
        let response = await RestManager.manager.requestObject(ErgastAPI.drivers(currentSeassonInt, team: team.constructorId), responseType: Drivers.self)

        switch response.result {
        case .success(let driversJSON):

            let currentSeasson = String(currentSeassonInt)
            
                    for driver in driversJSON.data.driverTable.drivers {
                        try await self.context.perform { [self] in
                                
                            let driversFetchrequest = DriversCDM.fetchRequest()
                                driversFetchrequest.fetchLimit = 1
                                driversFetchrequest.predicate = NSPredicate(format: "%K = %@ AND %K = %@ AND %K = %@",
                                                                #keyPath(DriversCDM.seassonId), currentSeasson,
                                                                #keyPath(DriversCDM.constructorId), team.constructorId!,
                                                                #keyPath(DriversCDM.driverId), driver.driverId)
                            
                            let driversResponse = try context.fetch(driversFetchrequest)
                            if let persistedDriver = driversResponse.first {
                                persistedDriver.seassonId = currentSeasson
                                persistedDriver.constructorId = team.constructorId
                                persistedDriver.driverId = driver.driverId
                                persistedDriver.url = driver.url
                                persistedDriver.code = driver.code
                                persistedDriver.nationality = driver.nationality
                                persistedDriver.permanentNumber = driver.permanentNumber
                                persistedDriver.givenName = driver.givenName
                                persistedDriver.familyName = driver.familyName
                                persistedDriver.dateOfBirth = driver.dateOfBirth
                                
                            } else {
                                let newDriver = DriversCDM(context: context)
                                newDriver.seassonId = currentSeasson
                                newDriver.constructorId = team.constructorId
                                newDriver.driverId = driver.driverId
                                newDriver.url = driver.url
                                newDriver.code = driver.code
                                newDriver.nationality = driver.nationality
                                newDriver.permanentNumber = driver.permanentNumber
                                newDriver.givenName = driver.givenName
                                newDriver.familyName = driver.familyName
                                newDriver.dateOfBirth = driver.dateOfBirth
                            }
                            
                            if context.hasChanges {
                                do {
                                    try context.save()
                                } catch {
                                    let nserror = error as NSError
                                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                                }
                            }

                        }
                        
                }
            
                //PersistenceController.shared.saveContext()


        case .failure(let error):
            throw error
        }
    }
    
}
