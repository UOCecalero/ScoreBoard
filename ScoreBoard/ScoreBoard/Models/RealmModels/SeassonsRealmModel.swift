//
//  SeassonsRealmModel.swift
//  ScoreBoard
//
//  Created by Eduard Calero on 24/9/22.
//  Copyright © 2022 Iflet.tech. All rights reserved.
//

import Foundation
import RealmSwift

final class SeassonsRealmModel: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var season: String
    
    convenience init(season: String) {
        self.init()
        self.season = season
    }
}
