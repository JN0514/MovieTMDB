//
//  Endpoints.swift
//  MovieDB
//
//  Created by JAYA$URYA on 25/10/25.
//

import Foundation

enum Endpoints {
    static func popular(pageNo: Int = 1) -> URL {
        URL(string: "\(AppConfig.baseURL)/movie/popular?api_key=\(AppConfig.apiKey)&page=\(pageNo)")!
    }
    static func search(query: String, pageNo: Int = 1) -> URL {
        let q = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        return URL(string: "\(AppConfig.baseURL)/search/movie?api_key=\(AppConfig.apiKey)&query=\(q)&page=\(pageNo)")!
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
    static func imagePath(path: String) -> URL {
        URL(string: "\(AppConfig.imageBaseURL)/w500/\(path)")!
    }
}
