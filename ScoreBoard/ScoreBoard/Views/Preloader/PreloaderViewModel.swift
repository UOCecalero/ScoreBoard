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
    
        try await SeasonModelLogic.shared.loadFromBackend()
        try await ConstructorsModelLogic.shared.loadFromBackend()
        try await DriversModelLogic.shared.loadFromBackend()
        try await RacesModelLogic.shared.loadFromBackend()
        
    }
    
    
    
}
