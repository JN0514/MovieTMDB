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
    
    func getDetail(movieId: Int) -> AnyPublisher<MovieDetail, Error> {
        client.fetch(MovieDetail.self, url: Endpoints.detail(id: movieId))
    }

    func getVideos(movieId: Int) -> AnyPublisher<[Video], Error> {
        client.fetch(ListResponse<Video>.self, url: Endpoints.videos(id: movieId))
            .map { $0.results ?? [] }
            .eraseToAnyPublisher()
    }

    func getCasts(movieId: Int) -> AnyPublisher<[Cast], Error> {
        client.fetch(ListResponse<Cast>.self, url: Endpoints.credit(id: movieId))
            .map { $0.cast ?? [] }
            .eraseToAnyPublisher()
    }
    
    func search(searchQuery: String) -> AnyPublisher<[Movie], Error> {
        client.fetch(ListResponse<Movie>.self, url: Endpoints.search(query: searchQuery))
            .map { $0.results ?? [] }
            .eraseToAnyPublisher()
    }
}
