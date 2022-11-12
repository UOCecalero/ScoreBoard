//
//  String+Extension.swift
//  ScoreBoard
//
//  Created by Eduard Calero on 8/10/22.
//  Copyright © 2022 Iflet.tech. All rights reserved.
//

import Foundation

extension String {
    
    var iso8601Date: Date? {
        let isoDateFormatter = ISO8601DateFormatter()
        return isoDateFormatter.date(from: self)
    }
    
}
