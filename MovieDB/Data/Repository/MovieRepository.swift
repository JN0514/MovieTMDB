//
//  MovieRepository.swift
//  MovieDB
//
//  Created by JAYA$URYA on 25/10/25.
//


import Foundation
import Combine

class MovieRepository: MovieRepositoryProtocol {
    private let client: APIClient

    init(client: APIClient = APIClient()) {
        self.client = client
    }

    func getPopular() -> AnyPublisher<[Movie], Error> {
        client.fetch(ListResponse<Movie>.self, url: Endpoints.popular())
            .map { $0.results ?? [] }
            .eraseToAnyPublisher()
    }
}
