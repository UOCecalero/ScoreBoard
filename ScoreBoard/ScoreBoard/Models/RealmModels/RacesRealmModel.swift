//
//  RacesRealmModel.swift
//  ScoreBoard
//
//  Created by Eduard Calero on 25/9/22.
//  Copyright © 2022 Iflet.tech. All rights reserved.
//

import Foundation
import RealmSwift

final class RacesRealmModel: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var id: String
    @Persisted var seassonId: String
    @Persisted var round: String
    @Persisted var url: String
    @Persisted var raceName: String
    @Persisted var circuit: CircuitRealmModel?
    @Persisted var date: String
    @Persisted var time: String

    
    
    convenience init(seasson: String, round: String, url: String, raceName: String, circuit: Circuit, date: String, time: String) {
        self.init()
        self.seassonId = seasson
        self.round = round
        self.url = url
        self.raceName = raceName
        self.circuit = CircuitRealmModel(circuitId: circuit.circuitId,
                                         url: circuit.url,
                                         circuitName: circuit.circuitName,
                                         location: circuit.location)
        self.date = date
        self.time = time
        
        self.id = "\(seasson)-\(round)"
    }
}


