//
//  ConstructorsRealmModel.swift
//  ScoreBoard
//
//  Created by Eduard Calero on 24/9/22.
//  Copyright © 2022 Iflet.tech. All rights reserved.
//

import Foundation
import RealmSwift

final class ConstructorsRealmModel: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var id: String
    @Persisted var seassonId: String
    @Persisted var constructorId: String
    @Persisted var url: String
    @Persisted var name: String
    @Persisted var nationality: String
    
    
    convenience init(seasson: String, constructorId: String, url: String, name: String, nationality: String) {
        self.init()
        self.seassonId = seasson
        self.constructorId = constructorId
        self.url = url
        self.name = name
        self.nationality = nationality
        
        self.id = "\(seasson)-\(constructorId)"
    }
}
