//
//  Race.swift
//  ScoreBoard
//
//  Created by Eduard Calero on 1/10/22.
//  Copyright © 2022 Iflet.tech. All rights reserved.
//

import Foundation

//
///// Codable struct, used for serializing JSON from the RaceSchedule endpoint.
//public struct RaceSchedule: Codable {
//    public let data: RaceScheduleData
//
//    private enum CodingKeys: String, CodingKey {
//        case data = "MRData"
//    }
//}
//
//public struct RaceScheduleData: Codable {
//    public let series: String
//    public let url: String
//    public let limit: String
//    public let offset: String
//    public let total: String
//    public let raceTable: RaceTable
//
//    private enum CodingKeys: String, CodingKey {
//        case series
//        case url
//        case limit
//        case offset
//        case total
//        case raceTable = "RaceTable"
//    }
//}

public struct RaceTable: Codable {
    public let season: String
    public let round: String?
    public let races: [Race]

    private enum CodingKeys: String, CodingKey {
        case season
        case round
        case races = "Races"
    }
}

public struct Race: Codable {
    public let season: String
    public let round: String
    public let url: String
    public let raceName: String
    public let circuit: Circuit
    public let date: String
    public let time: String
    public let raceResults: [RaceResult]?
    public let firstPracticeDateTime: RaceDateTime?
    public let secondPracticeDateTime: RaceDateTime?
    public let thirthPracticeDateTime: RaceDateTime?
    public let sprintDateTime: RaceDateTime?
    public let qualifyingDateTime: RaceDateTime?
    public let qualifyingResults: [QualifyingResult]?
    public let pitStops: [PitStop]?
    public let laps: [LapElement]?


    private enum CodingKeys: String, CodingKey {
        case season
        case round
        case url
        case raceName
        case circuit = "Circuit"
        case date
        case time
        case raceResults = "Results"
        case firstPracticeDateTime = "FirstPractice"
        case secondPracticeDateTime = "SecondPractice"
        case thirthPracticeDateTime = "ThirdPractice"
        case sprintDateTime = "Sprint"
        case qualifyingDateTime = "Qualifying"
        case qualifyingResults = "QualifyingResults"
        case pitStops = "PitStops"
        case laps = "Laps"
    }
}

public struct RaceDateTime: Codable {
    
    let date: String
    let time: String
    
}
