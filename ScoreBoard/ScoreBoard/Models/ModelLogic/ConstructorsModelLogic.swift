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
    
    let context = PersistenceController.shared.persistentCloudContainer.viewContext
    
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
            
            for constructor in constructorsJSON.data.constructorTable.constructors {
       
                         try await self.context.perform { [self] in
                                 
                             let constructorSeason = ConstructorsCDM.fetchRequest()
                                 constructorSeason.fetchLimit = 1
                                 constructorSeason.predicate = NSPredicate(format: "%K = %@ AND %K = %@",
                                                                 #keyPath(ConstructorsCDM.seassonId), currentSeasson,
                                                                 #keyPath(ConstructorsCDM.constructorId), constructor.constructorId)
                             
                             let seassonsResponse = try context.fetch(constructorSeason)
                             if let persistedConstructor = seassonsResponse.first {
                                 persistedConstructor.url = constructor.url
                                 persistedConstructor.name = constructor.name
                                 persistedConstructor.nationality = constructor.nationality
                             } else {
                                 let newConstructor = ConstructorsCDM(context: context)
                                 newConstructor.seassonId = currentSeasson
                                 newConstructor.constructorId = constructor.constructorId
                                 newConstructor.url = constructor.url
                                 newConstructor.name = constructor.name
                                 newConstructor.nationality = constructor.nationality
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
            
           // PersistenceController.shared.saveContext()
            
            
          
            
            
            
            
        case .failure(let error):
            throw error
        }
         
        
    }
    
}
