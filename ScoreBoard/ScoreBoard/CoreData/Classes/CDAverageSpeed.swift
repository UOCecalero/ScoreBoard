//
//  CDAverageSpeed.swift
//  ScoreBoard
//
//  Created by Eduard Calero on 8/10/22.
//  Copyright © 2022 Iflet.tech. All rights reserved.
//

import Foundation

public final class CDAverageSpeed: NSObject, NSSecureCoding {
    
    public let units: String
    public let speed: String
    
    init(with averageSpeed: AverageSpeed) {
        self.units = averageSpeed.units.rawValue
        self.speed = averageSpeed.speed
    }
    
    public static var supportsSecureCoding = true
    
    public func encode(with coder: NSCoder) {
        coder.encode(units, forKey: "units")
        coder.encode(speed, forKey: "speed")
    }
    
    public required init?(coder: NSCoder) {
        self.units = coder.decodeObject(of: NSString.self, forKey: "units") as? String ?? ""
        self.speed = coder.decodeObject(of: NSString.self, forKey: "speed") as? String ?? ""
    }
    
}
