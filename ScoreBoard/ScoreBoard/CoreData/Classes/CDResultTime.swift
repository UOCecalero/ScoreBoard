//
//  CDResultTime.swift
//  ScoreBoard
//
//  Created by Eduard Calero on 8/10/22.
//  Copyright © 2022 Iflet.tech. All rights reserved.
//

import Foundation

public final class CDResultTime: NSObject, NSSecureCoding {
    
    public let millis: String
    public let time: String
    
    init(width time: ResultTime) {
        
        self.millis = time.millis
        self.time = time.time
        
        super.init()
    }
    
    public static var supportsSecureCoding  = true
    
    public func encode(with coder: NSCoder) {
        coder.encode(millis, forKey: "millis")
        coder.encode(time, forKey: "rime")
    }
    
    public required init?(coder: NSCoder) {
        self.millis = coder.decodeObject(of: NSString.self, forKey: "millis") as? String ?? ""
        self.time = coder.decodeObject(of: NSString.self, forKey: "time") as? String ?? ""
    }
    

}
