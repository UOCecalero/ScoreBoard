//
//  CircuitRealmModel.swift
//  ScoreBoard
//
//  Created by Eduard Calero on 25/9/22.
//  Copyright © 2022 Iflet.tech. All rights reserved.
//

import Foundation
import RealmSwift

final class CircuitRealmModel: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var id: String
    @Persisted var url: String
    @Persisted var circuitName: String
    @Persisted var location: LocationRealmModel?
    
    convenience init(circuitId: String, url: String, circuitName: String, location: Location?) {
        self.init()
        self.id = circuitId
        self.url = url
        self.circuitName = circuitName
        if let location = location {
            self.location = LocationRealmModel(lat: location.lat,
                                               long: location.long,
                                               locality: location.locality,
                                               country: location.country)
        }
        
       
        
    }

}




