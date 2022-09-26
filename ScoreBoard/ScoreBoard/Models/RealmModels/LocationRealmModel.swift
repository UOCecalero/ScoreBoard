//
//  LocationRealmModel.swift
//  ScoreBoard
//
//  Created by Eduard Calero on 25/9/22.
//  Copyright © 2022 Iflet.tech. All rights reserved.
//

import Foundation
import RealmSwift

final class LocationRealmModel: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var id: String
    @Persisted var lat: String
    @Persisted var long: String
    @Persisted var locality: String
    @Persisted var country: String
    
    convenience init(lat: String, long: String, locality: String, country: String) {
        self.init()
        self.lat = lat
        self.long = long
        self.locality = locality
        self.country = country
        
        self.id = "\(lat)-\(long)"
        
    }
    
}
