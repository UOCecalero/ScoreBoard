//
//  CDRaceResult.swift
//  ScoreBoard
//
//  Created by Eduard Calero on 8/10/22.
//  Copyright © 2022 Iflet.tech. All rights reserved.
//

import Foundation


public final class CDRaceResult: NSObject, NSSecureCoding {
    
    public let number: String
    public let position: String
    public let positionText: String
    public let points: String
    public let driver: CDDriver
    public let constructor: CDConstructor
    public let grid, laps, status: String
    public let time: CDResultTime?
    public let fastestLap: CDFastestLap
    
    
     init(with raceResult: RaceResult) {
        self.number = raceResult.number
        self.position = raceResult.position
        self.positionText = raceResult.positionText
        self.points = raceResult.points
        self.driver = CDDriver(width: raceResult.driver)
        self.constructor = CDConstructor(with: raceResult.constructor)
        self.grid = raceResult.grid
        self.laps = raceResult.laps
        self.status = raceResult.status
        self.time = raceResult.time != nil ? CDResultTime(width: raceResult.time!) : nil
        self.fastestLap = CDFastestLap(width: raceResult.fastestLap)
    
        super.init()
        
    }
    
    public static var supportsSecureCoding = true
    
    public func encode(with coder: NSCoder) {
        coder.encode(number, forKey: "number")
        coder.encode(position, forKey: "position")
        coder.encode(positionText, forKey: "positionText")
        coder.encode(points, forKey: "points")
        coder.encode(driver, forKey: "Driver")
        coder.encode(constructor, forKey: "Constructor")
        coder.encode(grid, forKey: "grid")
        coder.encode(laps, forKey: "laps")
        coder.encode(status, forKey: "status")
        coder.encode(time, forKey: "Time")
        coder.encode(fastestLap, forKey: "FastestLap")
    }
    
    public required init?(coder: NSCoder)  {
        guard
            let number = coder.decodeObject(of: NSString.self, forKey: "number") as? String,
            let position = coder.decodeObject(of: NSString.self, forKey: "position") as? String,
            let positionText = coder.decodeObject(of: NSString.self, forKey: "positionText") as? String,
            let points = coder.decodeObject(of: NSString.self, forKey: "points") as? String,
            let driver = coder.decodeObject(of: CDDriver.self, forKey: "Driver"),
            let constructor = coder.decodeObject(of: CDConstructor.self, forKey: "Constructor"),
            let grid = coder.decodeObject(of: NSString.self, forKey: "grid") as? String,
            let lap = coder.decodeObject(of: NSString.self, forKey: "lap") as? String,
            let status = coder.decodeObject(of: NSString.self, forKey: "status") as? String,
            let time = coder.decodeObject(of: CDResultTime.self, forKey: "Time"),
            let fastestLap = coder.decodeObject(of: CDFastestLap.self, forKey: "FastestLap")
        else {
            return nil
        }
        
        self.number = number
        self.position = position
        self.positionText = positionText
        self.points = points
        self.driver = driver
        self.constructor = constructor
        self.grid = grid
        self.laps = lap
        self.status = status
        self.time = time
        self.fastestLap = fastestLap
    }
    
    
}
