//
//  CDPitStop.swift
//  ScoreBoard
//
//  Created by Eduard Calero on 8/10/22.
//  Copyright © 2022 Iflet.tech. All rights reserved.
//

import Foundation


public final class CDPitStop: NSObject, NSSecureCoding {
    
    public let driverId: String
    public let lap: String
    public let stop: String
    public let time: String
    public let duration: String
    
    public static var supportsSecureCoding  = true
    
    public func encode(with coder: NSCoder) {
        coder.encode(driverId, forKey: "driverId")
        coder.encode(lap, forKey: "lap")
        coder.encode(stop, forKey: "stop")
        coder.encode(time, forKey: "time")
        coder.encode(duration, forKey: "duration")
    }
    
    public required init?(coder: NSCoder) {

            self.driverId = coder.decodeObject(of: NSString.self, forKey: "driverId") as? String ?? ""
            self.lap = coder.decodeObject(of: NSString.self, forKey: "lap") as? String ?? ""
            self.time = coder.decodeObject(of: NSString.self, forKey: "driverId") as? String ?? ""
            self.stop = coder.decodeObject(of: NSString.self, forKey: "stop") as? String ?? ""
            self.duration = coder.decodeObject(of: NSString.self, forKey: "duration") as? String ?? ""
      
    }
    
    

}
