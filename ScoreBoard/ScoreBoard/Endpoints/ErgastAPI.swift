//
//  ErgastAPI.swift
//  ScoreBoard
//
//  Created by Eduard Calero on 21/9/22.
//  Copyright © 2022 Iflet.tech. All rights reserved.
//

import Foundation
import Alamofire

enum ErgastAPI: RequestBuilderProtocol {
    
    case seasson( limit: Int? = nil)
    case races(_ year: Int? = nil, limit: Int? = nil)
    case constructors(_ year: Int? = nil, limit: Int? = nil)
    case drivers(_ year: Int? = nil, team: String? = nil, limit: Int? = nil)
    
    case qualyResults(_ year: Int? = nil, round: Int? = nil, limit: Int? = nil)
    case raceResults(_ year: Int? = nil, round: Int? = nil, limit: Int? = nil)
    case pitStops(_ year: Int? = nil, round: Int? = nil, limit: Int? = nil)
    
    case contructorsResults(_ year: Int? = nil, round: Int? = nil, limit: Int? = nil)
    case driverResults(_ year: Int? = nil, round: Int? = nil, limit: Int? = nil)
    
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .seasson,
            .races,
            .constructors,
            .drivers,
            .qualyResults,
            .raceResults,
            .pitStops,
            .contructorsResults,
            .driverResults:

            return .get
            
        }
    }
    
    var encoding: Alamofire.URLEncoding {
        switch self {
            
        case .seasson,
            .races,
            .constructors,
            .drivers,
            .qualyResults,
            .raceResults,
            .pitStops,
            .contructorsResults,
            .driverResults:
        
            return .default
        }
    }
    
    
    var baseURLString: String { return "http://ergast.com/api/f1/" }
    
    var path: String {
        switch self {
        case .seasson:
            return "current/seasons.json"
            
        case .races(let nilOrYear, _):
            if let year = nilOrYear {
                return "\(year).json"
            } else {
                return "\(Constants.currentYear).json"
            }
            
        case .constructors(let nilOrYear, _):
            if let year = nilOrYear {
                return "\(year)/constructors.json"
            } else {
                return "\(Constants.currentYear)/constructors.json"
            }
            
        case .drivers(let nilOrYear, let team,  _):
            if let year = nilOrYear {
                if let team = team {
                    return "\(year)/constructors/\(team)/drivers.json"
                } else {
                    return "\(year)/dirvers.json"
                }
                
            } else {
                if let team = team {
                    return "\(Constants.currentYear)/constructors/\(team)/drivers.json"
                } else {
                    return "\(Constants.currentYear)/drivers.json"
                }
                
            }
            
        case .qualyResults(let nilOrYear, let round, _):
            
            if let year = nilOrYear {
                if let round = round {
                    return "\(year)/\(round)/qualifying.json"
                } else {
                    return "\(year)/qualifying.json"
                }
            } else {
                if let round = round {
                    return "\(Constants.currentYear)/\(round)/qualifying.json"
                } else {
                    return "\(Constants.currentYear)/qualifying.json"
                }
               
            }
            
        case .raceResults(let nilOrYear, let round, _):
            
            if let year = nilOrYear {
                if let round = round {
                    return "\(year)/\(round)/results.json"
                } else {
                    return "\(year)/results.json"
                }
            } else {
                if let round = round {
                    return "\(Constants.currentYear)/\(round)/results.json"
                } else {
                    return "\(Constants.currentYear)/results.json"
                }
               
            }
            
        case .pitStops(let nilOrYear, let round, _):
            
            if let year = nilOrYear {
                if let round = round {
                    return "\(year)/\(round)/pitstops.json"
                } else {
                    return "\(year)/pitstops.json"
                }
            } else {
                if let round = round {
                    return "\(Constants.currentYear)/\(round)/pitstops.json"
                } else {
                    return "\(Constants.currentYear)/pitstops.json"
                }
            }
            
        case .contructorsResults(let nilOrYear, let round, _):
            
            if let year = nilOrYear {
                if let round = round {
                    return "\(year)/\(round)/constructorStandings.json"
                } else {
                    return "\(year)/constructorStandings.json"
                }
            } else {
                if let round = round {
                    return "\(Constants.currentYear)/\(round)/constructorStandings.json"
                } else {
                    return "\(Constants.currentYear)/constructorStandings.json"
                }
               
            }
            
        case .driverResults(let nilOrYear, let round, _):

            if let year = nilOrYear {
                if let round = round {
                    return "\(year)/\(round)/driverStandings.json"
                } else {
                    return "\(year)/driverStandings.json"
                }
            } else {
                if let round = round {
                    return "\(Constants.currentYear)/\(round)/driverStandings.json"
                } else {
                    return "\(Constants.currentYear)/driverStandings.json"
                }
               
            }

        }
    }
    
    var headers: Alamofire.HTTPHeaders? {
    
        var httpHeaders = [HTTPHeader]()
        
        switch self {
        default:
            httpHeaders.append(HTTPHeader(name: "Accept", value: "*/*"))
        }
        
//        if requiresAuthorization {
//            let token = UserDefaultsHelper.getString(key: .accessToken)
//                switch API.manager.authenticationType {
//                case .basic:  headers.append(HTTPHeader(name: "Authorization", value: token))
//                case .bearer: headers.append(HTTPHeader(name: "Authorization", value: "Bearer \(token)"))
//                default: break
//                }
//        }
        
        
        return HTTPHeaders(httpHeaders)
        
    }
    
    var parameters: [String : Any]? {
        switch self {
        case    .seasson(let limit),
                .constructors(_, let limit),
                .races(_, let limit),
                .drivers(_, _, let limit),
                .qualyResults(_, _, let limit),
                .raceResults(_, _, let limit),
                .pitStops(_, _, let limit),
                .contructorsResults(_, _, let limit),
                .driverResults(_, _, let limit):
            
            if let limit = limit {
                return ["limit": "\(limit)"]
            }
        }
        
        return nil
    }
    
    var interceptor: Alamofire.RequestInterceptor? {
        switch self {
        default:
            return nil
        }
    }
    
    var requestModifiyer: Alamofire.Session.RequestModifier?{
        switch self {
        default:
            return nil
        }
    }
    
    var requiresAuthorization: Bool {
        switch self {
            default:
            return false
        }
    }
    
//    var returnType: T.Type {
//        switch self {
//        case .constructors:
//            return Constructors.self
//        }
//    }
    
    
}
