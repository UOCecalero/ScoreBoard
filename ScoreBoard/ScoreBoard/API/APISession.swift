//
//  APISession.swift
//  ScoreBoard
//
//  Created by Edu Calero on 18/08/2020.
//  Copyright © 2020 Iflet.tech. All rights reserved.
//

import Foundation
import Combine
import UIKit


enum APIError: Error {
    case decodingError(String?)
    case httpError(Int)
    case unknown
}

struct APISession: APIService {
    func request<T>(with builder: RequestBuilder) -> AnyPublisher<T, APIError> where T: Decodable {
        
//        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
         return URLSession.shared
            .dataTaskPublisher(for: builder.urlRequest)
            //            .debounce(for: .seconds(1), scheduler: RunLoop.main)
            .receive(on: DispatchQueue.main)
            .mapError { error in
                print("URLSession DatataskpublisherError: \(error.localizedDescription)")
                return .unknown }
            .flatMap { data, response -> AnyPublisher<T, APIError> in
                if let response = response as? HTTPURLResponse {
                    if (200...299).contains(response.statusCode) {
                    
                    return Just(data)
                        .decode(type: T.self, decoder: JSONDecoder())
                        .mapError {error -> APIError in .decodingError(error.localizedDescription)}
                        .eraseToAnyPublisher()
                    } else {
                        return Fail(error: APIError.httpError(response.statusCode))
                            .eraseToAnyPublisher()
                    }
                }
                return Fail(error: APIError.unknown)
                        .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }

    func requestImage(with url: String) -> AnyPublisher<UIImage, APIError> {
        guard let url = URL(string: url)
            else {
                return Fail(error: .decodingError(nil))
                    .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .mapError { _ in .unknown }
            .flatMap { data, response -> AnyPublisher<UIImage, APIError> in
                if let image = UIImage(data: data) {
                    return Just(image)
                        .mapError {error -> APIError in .decodingError(error.localizedDescription) }
                        .eraseToAnyPublisher()
                }
                return Fail(error: .unknown)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
        
    }
}
