//
//  Video.swift
//  MovieDB
//
//  Created by JAYA$URYA on 25/10/25.
//


struct Video: Codable, Identifiable {
    var id: String { key }
    let key: String
    let name: String
    let site: String
    let type: String
}
