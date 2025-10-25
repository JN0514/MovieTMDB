//
//  ListResponse.swift
//  MovieDB
//
//  Created by JAYA$URYA on 25/10/25.
//


struct ListResponse<T: Codable>: Codable {
    let results: [T]?
}
