//
//  Cast.swift
//  MovieDB
//
//  Created by JAYA$URYA on 25/10/25.
//

struct Cast: Codable, Identifiable, Equatable {
    let id: Int
    let name: String
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case profilePath = "profile_path"
    }
}
