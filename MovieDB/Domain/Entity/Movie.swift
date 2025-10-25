//
//  Movie.swift
//  MovieDB
//
//  Created by JAYA$URYA on 25/10/25.
//


struct Movie: Codable, Identifiable, Equatable {
    let id: Int
    let title: String
    let voteAverage: Double?
    let posterPath: String?

    enum CodingKeys: String, CodingKey {
        case id, title
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
    }
}
