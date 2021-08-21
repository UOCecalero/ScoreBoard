//
//  SportMonksPlayerSearchResponse.swift
//  ScoreBoard
//
//  Created by Edu Calero on 19/08/2020.
//  Copyright © 2020 Iflet.tech. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let sMPlayerSearchResponseModel = try? newJSONDecoder().decode(SMPlayerSearchResponseModel.self, from: jsonData)

import Foundation

// MARK: - SMPlayerSearchResponseModel
struct SMPlayerSearchResponseModel: Codable {
    let data: [SMPlayer]?
    let meta: Meta?
}

// MARK: - Datum
struct SMPlayer: Codable, Identifiable {
    
    let id = UUID()

    let playerID: Int32
    let teamID, countryID: Int?
    let positionID: Int?
    let commonName, displayName, fullname, firstname: String?
    let lastname, nationality: String?
    let birthdate: String?
    let birthcountry: String?
    let birthplace, height, weight: String?
    let imagePath: String?

    enum CodingKeys: String, CodingKey {
        case playerID = "player_id"
        case teamID = "team_id"
        case countryID = "country_id"
        case positionID = "position_id"
        case commonName = "common_name"
        case displayName = "display_name"
        case fullname, firstname, lastname, nationality, birthdate, birthcountry, birthplace, height, weight
        case imagePath = "image_path"
    }
}

// MARK: - Meta
struct Meta: Codable {
    let subscription: Subscription?
    let plan: Plan?
    let sports: [Sport]?
}

// MARK: - Plan
struct Plan: Codable {
    let name, price, requestLimit: String?

    enum CodingKeys: String, CodingKey {
        case name, price
        case requestLimit = "request_limit"
    }
}

// MARK: - Sport
struct Sport: Codable {
    let id: Int?
    let name: String?
    let current: Bool?
}

// MARK: - Subscription
struct Subscription: Codable {
    let startedAt: StartedAt?
    let trialEndsAt, endsAt: JSONNull?

    enum CodingKeys: String, CodingKey {
        case startedAt = "started_at"
        case trialEndsAt = "trial_ends_at"
        case endsAt = "ends_at"
    }
}

// MARK: - StartedAt
struct StartedAt: Codable {
    let date: String?
    let timezoneType: Int?
    let timezone: String?

    enum CodingKeys: String, CodingKey {
        case date
        case timezoneType = "timezone_type"
        case timezone
    }
}

//// MARK: - Encode/decode helpers
//
//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public func hash(into hasher: inout Hasher) {
//        // No-op
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}
