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
    let context = PersistenceController.shared.persistentCloudContainer.viewContext
    
    private init(){}
    
    
    func loadFromBackend() async throws {
        
        await withThrowingTaskGroup(of: Void.self) { group in
           
           group.addTask {
               try await self.loadRaces()
           }
        
            group.addTask {
                try await self.loadRacesResults()
            }
            
        }
        
    }

    
    func loadRaces() async throws {
        
        guard let currentSeassonInt = Int(currentSeasson) else {
            throw RacesModelLogicError.invalidCurrentSeasson
        }
        
        
        let response = await RestManager.manager.requestObject(ErgastAPI.races(currentSeassonInt), responseType: RaceResults.self)
            switch response.result {
            case .success(let racesJSON):

                let currentSeasson = String(currentSeassonInt)
                
                
                    for raceJSON in racesJSON.data.raceTable.races {
                        try await context.perform { [self] in
                            
                            let raceFetchRequest = RaceCDM.fetchRequest()
                            raceFetchRequest.fetchLimit = 1
                            raceFetchRequest.predicate = NSPredicate(format: "%K == %@ AND %K == %@",
                                                                     #keyPath(RaceCDM.seassonId), currentSeasson,
                                                                     #keyPath(RaceCDM.round), raceJSON.round)
                            
                            let racesResponse = try context.fetch(raceFetchRequest)
                            if let raceResponse = racesResponse.first {
                                raceResponse.seassonId = raceJSON.season
                                raceResponse.round =  raceJSON.round
                                raceResponse.raceName = raceJSON.raceName
                                raceResponse.url = raceJSON.url
                                raceResponse.circuit = try fetchCircuit(raceJSON.circuit)
                                raceResponse.date = raceJSON.date
                                raceResponse.time = raceJSON.time
                                
                                if let firstPracticeDateTime = raceJSON.firstPracticeDateTime {
                                    raceResponse.firstPracticeDateTime = CDRaceDateTime(width: firstPracticeDateTime)
                                }
                                
                                if let secondPracticeDateTime = raceJSON.secondPracticeDateTime {
                                    raceResponse.secondPracticeDateTime = CDRaceDateTime(width: secondPracticeDateTime)
                                }
                                
                                if let thirthPracticeDateTime = raceJSON.thirthPracticeDateTime {
                                    raceResponse.thirthPracticeDateTime =  CDRaceDateTime(width: thirthPracticeDateTime)
                                }
                                
                                if let qualifyingDateTime = raceJSON.qualifyingDateTime {
                                        raceResponse.qualifyingDateTime =  CDRaceDateTime(width: qualifyingDateTime)
                                }
                                
                                if let sprintDateTime = raceJSON.sprintDateTime {
                                    raceResponse.sprintDateTime = CDRaceDateTime(width: sprintDateTime)
                                }
                                
                            } else {
                                let newRace = RaceCDM(context: self.context)
                                newRace.seassonId = raceJSON.season
                                newRace.round =  raceJSON.round
                                newRace.raceName = raceJSON.raceName
                                newRace.url = raceJSON.url
                                newRace.circuit = try fetchCircuit(raceJSON.circuit)
                                
                                newRace.date = raceJSON.date
                                newRace.time = raceJSON.time
                                
                                if let firstPracticeDateTime = raceJSON.firstPracticeDateTime {
                                    newRace.firstPracticeDateTime = CDRaceDateTime(width: firstPracticeDateTime)
                                }
                                
                                if let secondPracticeDateTime = raceJSON.secondPracticeDateTime {
                                    newRace.secondPracticeDateTime = CDRaceDateTime(width: secondPracticeDateTime)
                                }
                                
                                if let thirthPracticeDateTime = raceJSON.thirthPracticeDateTime {
                                    newRace.thirthPracticeDateTime = CDRaceDateTime(width: thirthPracticeDateTime)
                                }
                                
                                if let qualifyingDateTime = raceJSON.qualifyingDateTime {
                                    newRace.qualifyingDateTime = CDRaceDateTime(width: qualifyingDateTime)
                                }
                                
                                if let sprintDateTime = raceJSON.sprintDateTime {
                                    newRace.sprintDateTime = CDRaceDateTime(width: sprintDateTime)
                                }
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
                
                
                
            case .failure(let error):
                throw error
            }
        }

    
    
    
    func loadRacesResults() async throws {
        
        guard let currentSeassonInt = Int(currentSeasson) else {
            throw RacesModelLogicError.invalidCurrentSeasson
        }
        
        
            let response = await RestManager.manager.requestObject(ErgastAPI.raceResults(currentSeassonInt), responseType: RaceResults.self)
            switch response.result {
            case .success(let racesJSON):

                let currentSeasson = String(currentSeassonInt)
                
                
                    for raceJSON in racesJSON.data.raceTable.races {
                           try await context.perform { [self] in
                                
                                let raceFetchRequest = RaceCDM.fetchRequest()
                                    raceFetchRequest.fetchLimit = 1
                                    raceFetchRequest.predicate = NSPredicate(format: "%K == %@ AND %K == %@",
                                                                         #keyPath(RaceCDM.seassonId), currentSeasson,
                                                                         #keyPath(RaceCDM.round), raceJSON.round)
                                
                                let racesResponse = try context.fetch(raceFetchRequest)
                                if let raceResponse = racesResponse.first {
                                    raceResponse.seassonId = raceJSON.season
                                    raceResponse.round =  raceJSON.round
                                    raceResponse.raceName = raceJSON.raceName
                                    raceResponse.url = raceJSON.url
                                    raceResponse.circuit = try fetchCircuit(raceJSON.circuit)
                                    raceResponse.date = raceJSON.date
                                    raceResponse.time = raceJSON.time
                                    
                                    if let raceResults = raceJSON.raceResults {
                                        
                                        var cdRaceResults = [CDRaceResult]()

                                        raceResults.forEach {
                                            cdRaceResults.append(CDRaceResult(with: $0))
                                        }

                                        raceResponse.results = cdRaceResults
                                    }
                                    

                                } else {
                                    let newRace = RaceCDM(context: self.context)
                                    newRace.seassonId = raceJSON.season
                                    newRace.round =  raceJSON.round
                                    newRace.raceName = raceJSON.raceName
                                    newRace.url = raceJSON.url
                                    newRace.circuit = try fetchCircuit(raceJSON.circuit)
                                    
                                    newRace.date = raceJSON.date
                                    newRace.time = raceJSON.time
                                    
                                    if let raceResults = raceJSON.raceResults {
                                        
                                        var cdRaceResults = [CDRaceResult]()

                                        raceResults.forEach {
                                            cdRaceResults.append(CDRaceResult(with: $0))
                                        }

                                        newRace.results = cdRaceResults
                                    }
                                }
                               
                               
                               if context.hasChanges {
                                   try context.save()
                               }
                            }
                            
                    }
                
                //PersistenceController.shared.saveContext()
                
                
                
                
            case .failure(let error):
                throw error
            }
        }
    
}

extension RacesModelLogic {
    
    fileprivate func fetchCircuit(_ circuitJSON: Circuit) throws -> CircuitCDM {
        
            
            let circuitFetchRequest = CircuitCDM.fetchRequest()
                circuitFetchRequest.fetchLimit = 1
                circuitFetchRequest.predicate = NSPredicate(format: "%K == %@",
                                                            #keyPath(CircuitCDM.circuitId), circuitJSON.circuitId)
            
            let circuitsResponse = try context.fetch(circuitFetchRequest)
            if let circuitResponse = circuitsResponse.first {
                circuitResponse.circuitId = circuitJSON.circuitId
                circuitResponse.url =  circuitJSON.url
                circuitResponse.circuitName = circuitJSON.circuitName
                if let circuitJSONLocation = circuitJSON.location {
                    circuitResponse.location = try fetchLocation(circuitJSONLocation)
                }
                
                return circuitResponse

            } else {
                let newCircuit = CircuitCDM(context: self.context)
                newCircuit.circuitId = circuitJSON.circuitId
                newCircuit.url =  circuitJSON.url
                newCircuit.circuitName = circuitJSON.circuitName
                if let circuitJSONLocation = circuitJSON.location {
                    newCircuit.location = try fetchLocation(circuitJSONLocation)
                }
               
                
                return newCircuit
            
        }
    }
    
    
    fileprivate func fetchLocation(_ locationJSON: Location) throws -> LocationCDM {
        
            
            let locationFetchRequest = LocationCDM.fetchRequest()
                locationFetchRequest.fetchLimit = 1
                locationFetchRequest.predicate = NSPredicate(format: "%K == %@ AND %K == %@",
                                                            #keyPath(LocationCDM.lat), locationJSON.lat,
                                                             #keyPath(LocationCDM.long), locationJSON.long)
            
            let locationsResponse = try self.context.fetch(locationFetchRequest)
            if let locationResponse = locationsResponse.first {
                locationResponse.lat = locationJSON.lat
                locationResponse.long =  locationJSON.long
                locationResponse.country = locationJSON.country
                locationResponse.locality = locationJSON.locality
                
                return locationResponse
                
            } else {
                let newLocation = LocationCDM(context: self.context)
                newLocation.lat = locationJSON.lat
                newLocation.long =  locationJSON.long
                newLocation.country = locationJSON.country
                newLocation.locality = locationJSON.locality
                
                return newLocation
            }
        
    }
}
