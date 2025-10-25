//
//  MovieRepositoryProtocol.swift
//  MovieDB
//
//  Created by JAYA$URYA on 25/10/25.
//


import Combine

protocol MovieRepositoryProtocol {
    func getPopular() -> AnyPublisher<[Movie], Error>
    func getDetail(movieId: Int) -> AnyPublisher<MovieDetail, Error>
    func getVideos(movieId: Int) -> AnyPublisher<[Video], Error>
    func getCasts(movieId: Int) -> AnyPublisher<[Cast], Error>
    func search(searchQuery: String) -> AnyPublisher<[Movie], Error>
}
