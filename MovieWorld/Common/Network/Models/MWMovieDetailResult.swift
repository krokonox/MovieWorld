//
//  MovieDetailResult.swift
//  MovieWorld
//
//  Created by Admin on 06/03/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

struct MWMovieDetailResult: Decodable {
    let id: Int
    let title: String
    let genres: [Genre]?
    let posterPath: String?
    let releaseDate: String
    let voteAverage: Double
    let overview: String
    var videos: MWMovieVideoResponse?
    var credits: MWCreditsResponse?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case genres
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
        case videos
        case credits
    }
    
    func returnAsMovie() -> MWMovie {
        let genreIds = genres?.compactMap { $0.id } ?? []
        return MWMovie(id: id,
                       title: title,
                       genreIds: genreIds,
                       releaseDate: releaseDate,
                       posterPath: posterPath,
                       voteAverage: voteAverage,
                       overview: overview)
    }
}

struct MWCreditsResponse: Decodable {
    let cast: [Cast]
}

struct Cast: Decodable {
    let cast_id: Int
    let character: String
    let id: Int
    let name: String
    let profile_path: String?
}
