//
//  MovieRepositoryProtocol.swift
//  MovieDB
//
//  Created by JAYA$URYA on 25/10/25.
//


import Combine

protocol MovieRepositoryProtocol {
    func getPopular() -> AnyPublisher<[Movie], Error>
}
