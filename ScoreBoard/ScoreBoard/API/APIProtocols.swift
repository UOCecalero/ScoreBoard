//
//  APIProtocols.swift
//  ScoreBoard
//
//  Created by Edu Calero on 18/08/2020.
//  Copyright © 2020 Iflet.tech. All rights reserved.
//

import UIKit
import Combine

protocol APIService {
    func request<T: Decodable>(with builder: RequestBuilder) -> AnyPublisher<T, APIError>
    func requestImage(with url: String) -> AnyPublisher<UIImage, APIError>
}

protocol RequestBuilder {
    var urlRequest: URLRequest {get}
}

