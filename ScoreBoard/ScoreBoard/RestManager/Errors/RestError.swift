//
//  RestError.swift
//  ScoreBoard
//
//  Created by Eduard Calero on 24/9/22.
//  Copyright © 2022 Iflet.tech. All rights reserved.
//

import Foundation

enum RestError: Error, LocalizedError {
    
    case endpointURLError
    case uknown
    
    
    var errorDescription: String {
        switch self {
        case .endpointURLError: return "Endpoint URL can't be retreived"
        default:
            return "Uknown error"
        }
    }
    
}


enum RestCombineError: Error, LocalizedError {
    case requestURLError
    case decodingError(String?)
    case httpError(Int)
    case unknown
    
    var errorDescription: String {
        switch self {
        case .requestURLError:              return "ResquestURL can't be constructed"
        case .decodingError(let error):     return "\(error ?? "")"
        case .httpError(let errorCode):     return "HTTP Error code \(errorCode)"
        default:
            return "Uknown error"
        }
    }
}
