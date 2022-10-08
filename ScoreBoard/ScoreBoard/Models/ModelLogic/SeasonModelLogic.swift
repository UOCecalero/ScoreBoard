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
    
    let context = PersistenceController.shared.persistentCloudContainer.viewContext

    private init(){}
    
    func loadFromBackend() async throws {
        
        let response = await RestManager.manager.requestObject(ErgastAPI.seasson(), responseType: Seasons.self)
        
        switch response.result {
        case .success(let currentSeasonJSON):
            
            guard let currentSeassonString = currentSeasonJSON.data.seasonTable.seasons.first?.season,
                  !currentSeassonString.isEmpty else {
                throw ModelLogicError.notCurrenSeassonFound
            }
            
            try await context.perform { [self] in
                    
                let fetchSeason = SeassonCDM.fetchRequest()
                    fetchSeason.fetchLimit = 1
                    fetchSeason.predicate = NSPredicate(format: "%K = %@", #keyPath(SeassonCDM.seasson), currentSeassonString)
                
                let seassonsResponse = try context.fetch(fetchSeason)
                if let persistedSeasson = seassonsResponse.first {
                    //Nothing to do
                } else {
                    let newSeasson = SeassonCDM(context: context)
                    newSeasson.seasson = currentSeassonString
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
            
           // PersistenceController.shared.saveContext()
            currentSeasson = currentSeassonString
            
            
        case .failure(let error):
            throw error
        }
    }
    
}
