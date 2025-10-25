//
//  Endpoints.swift
//  MovieDB
//
//  Created by JAYA$URYA on 25/10/25.
//

import Foundation

enum Endpoints {
    static func popular() -> URL {
        URL(string: "\(AppConfig.baseURL)/movie/popular?api_key=\(AppConfig.apiKey)")!
    }
    static func search(query: String) -> URL {
        let q = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        return URL(string: "\(AppConfig.baseURL)/search/movie?api_key=\(AppConfig.apiKey)&query=\(q)")!
    }
    static func detail(id: Int) -> URL {
        URL(string: "\(AppConfig.baseURL)/movie/\(id)?api_key=\(AppConfig.apiKey)")!
    }
    static func videos(id: Int) -> URL {
        URL(string: "\(AppConfig.baseURL)/movie/\(id)/videos?api_key=\(AppConfig.apiKey)")!
    }
    static func credit(id: Int) -> URL {
        URL(string: "\(AppConfig.baseURL)/movie/\(id)/credits?api_key=\(AppConfig.apiKey)")!
    }
    static func imagePath(id: Int) -> URL {
        URL(string: "\(AppConfig.imageBaseURL)/w500/\(id)")!
    }
}
