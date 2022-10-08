//
//  CDQualifyingResult.swift
//  ScoreBoard
//
//  Created by Eduard Calero on 8/10/22.
//  Copyright © 2022 Iflet.tech. All rights reserved.
//

import Foundation

public final class CDQualifyingResult: NSObject, NSSecureCoding {
    
    public let number: String
    public let position: String
    public let driver: CDDriver
    public let constructor: CDConstructor
    public let q1: String
    public let q2: String?
    public let q3: String?
    
    public static var supportsSecureCoding = true
    
    public func encode(with coder: NSCoder) {
        coder.encode(number, forKey: "number")
        coder.encode(position, forKey: "position")
        coder.encode(driver, forKey: "Driver")
        coder.encode(constructor, forKey: "Constructor")
        coder.encode(q1, forKey: "Q1")
        coder.encode(q2, forKey: "Q2")
        coder.encode(q3, forKey: "Q3")
    }
    
    public required init?(coder: NSCoder) {
        
        guard let driver = coder.decodeObject(of: CDDriver.self, forKey: "Driver"),
              let constructor = coder.decodeObject(of: CDConstructor.self, forKey: "Constructor") else {
            return nil
        }
        
        self.number = coder.decodeObject(of: NSString.self, forKey: "number") as? String ?? ""
        self.position = coder.decodeObject(of: NSString.self, forKey: "position") as? String ?? ""
        self.driver = driver
        self.constructor = constructor
        self.q1 = coder.decodeObject(of: NSString.self, forKey: "Q1") as? String ?? ""
        self.q2 = coder.decodeObject(of: NSString.self, forKey: "Q2") as? String ?? ""
        self.q3 = coder.decodeObject(of: NSString.self, forKey: "Q3") as? String ?? ""
    }
    
    
}
