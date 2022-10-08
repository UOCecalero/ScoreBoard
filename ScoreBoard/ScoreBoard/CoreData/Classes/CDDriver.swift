//
//  CDDriver.swift
//  ScoreBoard
//
//  Created by Eduard Calero on 8/10/22.
//  Copyright © 2022 Iflet.tech. All rights reserved.
//

import Foundation

public class CDDriver: NSObject, NSSecureCoding {
    
    public let driverId: String
    public let permanentNumber: String?
    public let code: String?
    public let url: String
    public let givenName: String
    public let familyName: String
    public let dateOfBirth: String
    public let nationality: String
    
    init(width driver: Driver) {
        self.driverId = driver.driverId
        self.permanentNumber = driver.permanentNumber
        self.code = driver.code
        self.url = driver.url
        self.givenName = driver.givenName
        self.familyName = driver.familyName
        self.dateOfBirth = driver.dateOfBirth
        self.nationality = driver.nationality
        
        super.init()
    }
    
    public static var supportsSecureCoding = true
    
    public func encode(with coder: NSCoder) {
        coder.encode(driverId, forKey: "driverId")
        coder.encode(permanentNumber, forKey: "permanentNumber")
        coder.encode(code, forKey: "code")
        coder.encode(url, forKey: "url")
        coder.encode(givenName, forKey: "givenName")
        coder.encode(familyName, forKey: "familyName")
        coder.encode(dateOfBirth, forKey: "dateOfBirth")
        coder.encode(nationality, forKey: "nationality")
    }
    
    public required init?(coder: NSCoder) {
        self.driverId = coder.decodeObject(of: NSString.self, forKey: "driverId") as? String ?? ""
        self.permanentNumber = coder.decodeObject(of: NSString.self, forKey: "permanentNumber") as? String ?? ""
        self.code = coder.decodeObject(of: NSString.self, forKey: "code") as? String
        self.url = coder.decodeObject(of: NSString.self, forKey: "url") as? String ?? ""
        self.givenName = coder.decodeObject(of: NSString.self, forKey: "givenName") as? String ?? ""
        self.familyName = coder.decodeObject(of: NSString.self, forKey: "familyName") as? String ?? ""
        self.dateOfBirth = coder.decodeObject(of: NSString.self, forKey: "dateOfBirth") as? String ?? ""
        self.nationality = coder.decodeObject(of: NSString.self, forKey: "nationality") as? String ?? ""
    }
    
    
}
