//
//  MovieDetail.swift
//  MovieDB
//
//  Created by JAYA$URYA on 25/10/25.
//


struct MovieDetail: Codable {
    let id: Int
    let title: String
    let overview: String?
    let backdrop_path: String?
    let genres: [Genre]
    let runtime: Int?
    let vote_average: Double?

    struct Genre: Codable {
        let id: Int
        let name: String
    }
}
