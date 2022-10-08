//
//  CDRaceDateTime.swift
//  ScoreBoard
//
//  Created by Eduard Calero on 8/10/22.
//  Copyright © 2022 Iflet.tech. All rights reserved.
//

import Foundation


public final class CDRaceDateTime: NSObject, NSSecureCoding {
    
    let date: String
    let time: String
    
    init(width raceDateTime: RaceDateTime) {
        self.date = raceDateTime.date
        self.time = raceDateTime.time
        super.init()
    }
    
    public static var supportsSecureCoding = true
    
    public func encode(with coder: NSCoder) {
        coder.encode(date, forKey: "date")
        coder.encode(time, forKey: "time")
    }

    public required init?(coder: NSCoder) {
        self.date = coder.decodeObject(of: NSString.self, forKey: "date") as? String ?? ""
        self.time = coder.decodeObject(of: NSString.self, forKey: "time") as? String ?? ""
    }
    
    
}
