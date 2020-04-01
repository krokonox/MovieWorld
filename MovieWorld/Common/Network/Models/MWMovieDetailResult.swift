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
    let poster_path: String?
    let release_date = "release_date"
    let vote_average: Double
    let overview: String
    var videos: MWMovieVideoResponse?
    var credits: MWCreditsResponse?
    
    func returnAsMovie() -> MWMovie {
        let genreIds = genres?.compactMap { $0.id } ?? []
        return MWMovie(id: id,
                       title: title,
                       genre_ids: genreIds,
                       release_date: release_date,
                       poster_path: poster_path,
                       vote_average: vote_average,
                       overview: overview
                       )
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
