//
//  PlayerResponseModel.swift
//  ScoreBoard
//
//  Created by Edu Calero on 17/08/2020.
//  Copyright © 2020 Iflet.tech. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let playerResponseModel = try? newJSONDecoder().decode(PlayerResponseModel.self, from: jsonData)

import Foundation

// MARK: - PlayerResponseModel
struct PlayerResponseModel: Decodable {
    let api: API
}

// MARK: - API
struct API: Decodable {
    let results: Int?
    let players: [Player]?
}

// MARK: - Player
struct Player: Decodable, Identifiable {
    
    var id: Int { self.playerID }

    let playerID: Int
    let playerName, firstname, lastname: String
    let number: JSONNull?
    let position: String?
    let age: Int?
    let birthDate, birthPlace, birthCountry, nationality: JSONNull?
    let height, weight: JSONNull?

    enum CodingKeys: String, CodingKey {
        case playerID = "player_id"
        case playerName = "player_name"
        case firstname, lastname, number, position, age
        case birthDate = "birth_date"
        case birthPlace = "birth_place"
        case birthCountry = "birth_country"
        case nationality, height, weight
    }
}
