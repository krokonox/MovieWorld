//
//  MovieDetailResult.swift
//  MovieWorld
//
//  Created by Admin on 06/03/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

struct MWMovieDetailResult: Decodable {
    let title: String
    let genres: [Genre]?
    let poster_path: String?
    let release_date = "release_date"
    let vote_average: Double
    
    func returnAsMovie() -> MWMovie {
        let genreIds = genres?.compactMap { $0.id } ?? []
        return MWMovie(title: title, genre_ids: genreIds, release_date: release_date, poster_path: poster_path, vote_average: vote_average)
    }
}
