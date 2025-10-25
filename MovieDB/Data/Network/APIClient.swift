//
//  APIClient.swift
//  MovieDB
//
//  Created by JAYA$URYA on 25/10/25.
//

import Foundation
import Combine

class APIClient {
    private let session: URLSession
    init(session: URLSession = .shared) { self.session = session }

    func fetch<T: Codable>(_ url: URL) -> AnyPublisher<T, Error> {
        session.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    func fetch<T: Codable>(_ type: T.Type, url: URL) -> AnyPublisher<T, Error> {
        fetch(url)
    }
}
