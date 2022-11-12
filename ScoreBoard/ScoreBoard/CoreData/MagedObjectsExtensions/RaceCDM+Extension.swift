//
//  RaceCDM+Extension.swift
//  ScoreBoard
//
//  Created by Eduard Calero on 8/10/22.
//  Copyright © 2022 Iflet.tech. All rights reserved.
//

import Foundation


extension RaceCDM {
    
    var ISODateTimeString: String {
       
        guard let date = self.swiftDate else {
            return ""
        }
           
        return date.ISO8601Format()
        
    }
    
    var swiftDate: Date? {
        
        guard let dateString = self.date, !dateString.isEmpty,
              let timeString = self.time, !timeString.isEmpty else {
            return nil
        }
                  
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
          
          //yyyy-MM-dd'T'HH:mm:ssZ
          let dateTimeString = "\(dateString)T\(timeString)"
          return dateFormatter.date(from: dateTimeString)
    }
}
