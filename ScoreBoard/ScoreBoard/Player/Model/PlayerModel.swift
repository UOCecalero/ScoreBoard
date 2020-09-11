//
//  PlayerModel.swift
//  ScoreBoard
//
//  Created by Edu Calero on 17/08/2020.
//  Copyright © 2020 Iflet.tech. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let player = try? newJSONDecoder().decode(Player.self, from: jsonData)

import Foundation

// MARK: - Player
struct PlayerModel: Codable {
    let playerID: Int
    let playerName, firstname, lastname: String
    let number: JSONNull?
    let position: String
    let age: Int
    let birthDate, birthPlace, birthCountry, nationality: JSONNull?
    let height, weight: String

    enum CodingKeys: String, CodingKey {
        case playerID
        case playerName
        case firstname, lastname, number, position, age
        case birthDate
        case birthPlace
        case birthCountry
        case nationality, height, weight
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public func hash(into hasher: inout Hasher) {
        // No-op
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
