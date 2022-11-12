//
//  GrandPrixViewModel.swift
//  ScoreBoard
//
//  Created by Eduard Calero on 1/10/22.
//  Copyright © 2022 Iflet.tech. All rights reserved.
//

import Foundation


struct NextEventInfo {
    let name: String
    let startTime: Date
    let remianingTimeString: String
}

class GrandPrixViewModel: ObservableObject {
    
    deinit {
        self.countDownTimer?.invalidate()
    }
    
    var countDownTimer: Timer?
    
    @Published var race: RaceCDM?
    @Published var nexEventInfo: NextEventInfo?
    
    let context = PersistenceController.shared.persistentCloudContainer.viewContext
    
    func fetchRace() async {
        
        do {
            
            try await context.perform {
                
                let racesFetchRequest = RaceCDM.fetchRequest()
                let fetchedRaces = try self.context.fetch(racesFetchRequest)
                if let race = fetchedRaces.last(where: { r in
                    if let swiftDate = r.swiftDate {
                        return swiftDate >= Date()
                    } else {
                        return false
                    }
                }) {
                        self.race = race
                } else {
                        self.race = nil
                }
            }
            
        } catch {
            print("fetchRaceError: \(error)")
        }
        
    }
    
    
    
    func initCountdownIfNeeded(){
        
        guard let race = self.race else {
            self.nexEventInfo = nil
            return
        }
        
        if let raceInitTime = race.swiftDate {
            
            let nextEventInfo = NextEventInfo(name: "RACE STARTS IN",
                                              startTime: raceInitTime,
                                              remianingTimeString: "")
            
            reloadCountDown(with: nextEventInfo)
        }
        
    }
    
    
    func reloadCountDown(with nextEventInfo: NextEventInfo) {
        
        self.countDownTimer?.invalidate()
        self.nexEventInfo = nextEventInfo
    
        
        self.countDownTimer = Timer.scheduledTimer(withTimeInterval: 1,
                                    repeats: true,
                                    block: { _ in
            
            
            
         

            let components = Calendar.current.dateComponents([.day, .hour , .minute, .second],
                                                             from: Date(),
                                                             to: self.nexEventInfo!.startTime)
            
            var componentsString = ""
            if components.day ?? 0 > 0 {
                componentsString.append("\(components.day ?? 0)D ")
            }
            
            if let componentsHour = components.hour,
               let componentsMinute = components.minute,
               let componentsSecond = components.second {
                
                if componentsHour < 10 {
                    componentsString.append("0")
                }
                
                componentsString.append("\(componentsHour):")
                
                if componentsMinute < 10 {
                    componentsString.append("0")
                }
                
                componentsString.append("\(componentsMinute):")
    
                
                if componentsSecond < 10 {
                    componentsString.append("0")
                }
                
                componentsString.append("\(componentsSecond)")
                
            } else {
                componentsString.append("\(components.hour ?? 0):\(components.minute ?? 0):\(components.second ?? 0)")
            }
            
 
            let newNextEvent = NextEventInfo(name: self.nexEventInfo!.name,
                                             startTime: self.nexEventInfo!.startTime,
                                             remianingTimeString: componentsString)
            
            self.nexEventInfo = newNextEvent
            
        })
        
    }

    
}
