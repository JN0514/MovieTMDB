//
//  MovieDetailModel.swift
//  MovieDB
//
//  Created by JAYA$URYA on 25/10/25.
//

struct MovieDetailModel: Codable {
    var moveDetail: MovieDetail
    var castList: [Cast]
    var trailerVideo: Video?
}
