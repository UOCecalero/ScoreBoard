//
//  PreloaderViewModel.swift
//  ScoreBoard
//
//  Created by Eduard Calero on 24/9/22.
//  Copyright © 2022 Iflet.tech. All rights reserved.
//

import Foundation

class PreloaderViewModel: ObservableObject {
    
     func downloadData() async throws {
         
         if let lastLoadDateString = UserDefaults.standard.string(forKey: "LastLoadDate"),
            let lastLoadDate = lastLoadDateString.iso8601Date,
            Calendar.current.isDate(Date(), inSameDayAs: lastLoadDate) {
             return
         }
    
        try await SeasonModelLogic.shared.loadFromBackend()
        try await ConstructorsModelLogic.shared.loadFromBackend()
        try await DriversModelLogic.shared.loadFromBackend()
        try await RacesModelLogic.shared.loadFromBackend()
         
         UserDefaults.standard.setValue(Date().ISO8601Format(), forKey: "LastLoadDate")
    }
}
