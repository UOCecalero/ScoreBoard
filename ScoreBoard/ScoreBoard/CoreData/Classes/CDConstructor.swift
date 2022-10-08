//
//  CDConstructor.swift
//  ScoreBoard
//
//  Created by Eduard Calero on 8/10/22.
//  Copyright © 2022 Iflet.tech. All rights reserved.
//

import Foundation


public final class CDConstructor: NSObject, NSSecureCoding {
    
    public let constructorId: String
    public let url: String
    public let name: String
    public let nationality: String
    
    init(with constructor: Constructor) {
        self.constructorId = constructor.constructorId
        self.url = constructor.url
        self.name = constructor.name
        self.nationality = constructor.nationality
        
        super.init()
    }
    
    public static var supportsSecureCoding = true
    
    public func encode(with coder: NSCoder) {
        coder.encode(constructorId, forKey: "constructorId")
        coder.encode(url, forKey: "url")
        coder.encode(name, forKey: "name")
        coder.encode(nationality, forKey: "nationality")
    }
    
    public init?(coder: NSCoder) {
        guard let constructorId = coder.decodeObject(of: NSString.self, forKey: "constructorId") as? String else {
            return nil
        }
        
        self.constructorId = constructorId
        self.url = coder.decodeObject(of: NSString.self, forKey: "url") as? String ?? ""
        self.name = coder.decodeObject(of: NSString.self, forKey: "name") as? String ?? ""
        self.nationality = coder.decodeObject(of: NSString.self, forKey: "nationality") as? String ?? ""
    }
    
    
}
