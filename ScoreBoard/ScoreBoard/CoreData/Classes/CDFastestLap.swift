//
//  CDFastestLap.swift
//  ScoreBoard
//
//  Created by Eduard Calero on 8/10/22.
//  Copyright © 2022 Iflet.tech. All rights reserved.
//

import Foundation


public final class CDFastestLap: NSObject, NSSecureCoding {
    
    public let rank: String
    public let lap: String
    public let time: CDFastestLapTime
    public let averageSpeed: CDAverageSpeed

    init(width fastestLap: FastestLap) {
        
        self.rank = fastestLap.rank
        self.lap = fastestLap.lap
        self.time = CDFastestLapTime(with: fastestLap.time)
        self.averageSpeed = CDAverageSpeed(with: fastestLap.averageSpeed)
        
        super.init()
    }
    
    public static var supportsSecureCoding = true
    
    public func encode(with coder: NSCoder) {
        coder.encode(rank, forKey: "rank")
        coder.encode(lap, forKey: "lap")
        coder.encode(time, forKey: "Time")
        coder.encode(averageSpeed, forKey: "AverageSpeed")
    }
    
    public required init?(coder: NSCoder) {
        
        guard let time = coder.decodeObject(of: CDFastestLapTime.self, forKey: "Time"),
              let avgSpeed = coder.decodeObject(of: CDAverageSpeed.self, forKey: "AverageSpeed") else {
            return nil
        }
        
        self.rank = coder.decodeObject(of: NSString.self, forKey: "rank") as? String ?? ""
        self.lap = coder.decodeObject(of: NSString.self, forKey: "lap") as? String ?? ""
        self.time = time
        self.averageSpeed = avgSpeed
        
    }
}
