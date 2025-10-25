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
        return Future<T, Error> { promise in
                URLSession.shared.dataTask(with: url) { data, response, err in
                    if let error = err {
                        promise(.failure(error))
                        return
                    }
                    
                    guard let data = data else {
                        promise(.failure(URLError(.badServerResponse)))
                        return
                    }
                    
                    do {
                        let dataModel = try JSONDecoder().decode(T.self, from: data)
                        promise(.success(dataModel))
                    } catch {
                        promise(.failure(error))
                    }
                }
                .resume()
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    func fetch<T: Codable>(_ type: T.Type, url: URL) -> AnyPublisher<T, Error> {
        fetch(url)
    }
}
