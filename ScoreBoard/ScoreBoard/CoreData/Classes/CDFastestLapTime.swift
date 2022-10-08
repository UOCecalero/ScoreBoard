//
//  CDFastestLapTime.swift
//  ScoreBoard
//
//  Created by Eduard Calero on 8/10/22.
//  Copyright © 2022 Iflet.tech. All rights reserved.
//

import Foundation

public final class CDFastestLapTime: NSObject, NSSecureCoding {
    
    
    public let time: String
    
    init(with time: FastestLapTime){
        self.time = time.time
        super.init()
    }
    
    public static var supportsSecureCoding = true
    
    public func encode(with coder: NSCoder) {
        coder.encode(time, forKey: "time")
    }
    
    public required init?(coder: NSCoder) {
        self.time = coder.decodeObject(of: NSString.self, forKey: "time") as? String ?? ""
    }
    
}
