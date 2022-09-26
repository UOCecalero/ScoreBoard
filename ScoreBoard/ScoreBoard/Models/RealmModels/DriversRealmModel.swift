//
//  DriversRealmModel.swift
//  ScoreBoard
//
//  Created by Eduard Calero on 25/9/22.
//  Copyright © 2022 Iflet.tech. All rights reserved.
//

import Foundation
import RealmSwift

final class DriversRealmModel: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var id: String
    @Persisted var seassonId: String
    @Persisted var constructorId: String
    @Persisted var driverId: String
    @Persisted var url: String
    @Persisted var givenName: String
    @Persisted var familyName: String
    @Persisted var dateOfBirth: String
    @Persisted var nationality: String
    @Persisted var code: String
    @Persisted var permanentNumber: String
    
    
    convenience init(seasson: String, constructorId: String, driverId: String, url: String, givenName: String, familyName: String, dateOfBirth: String, nationality: String, code: String = "", permanentNumer: String = "") {
        self.init()
        self.seassonId = seasson
        self.constructorId = constructorId
        self.driverId = driverId
        self.url = url
        self.givenName = givenName
        self.familyName = familyName
        self.dateOfBirth = dateOfBirth
        self.nationality = nationality
        
        self.id = "\(seasson)-\(constructorId)-\(driverId)"
    }
}
