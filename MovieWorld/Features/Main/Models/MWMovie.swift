//
//  MWMovie.swift
//  MovieWorld
//
//  Created by Admin on 25/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

struct MWMovie: Decodable, Equatable {
    var id: Int
    var title: String
    var genreIds: [Int16]
    var releaseDate: String
    var posterPath: String?
    var voteAverage: Double
    var overview: String
    var videos: MWMovieVideoResponse?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case genreIds = "genre_ids"
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
        case videos
    }
    
    static func == (lhs: MWMovie, rhs: MWMovie) -> Bool {
        return lhs.id == rhs.id
    }
}

struct MWMovieVideoResponse: Decodable {
    let results: [MovieVideo]
}

struct MovieVideo: Decodable {
    let id: String
    let key: String
    let name: String
    let site: String
    let size: Int
    let type: String
    
    var youtubeURL: URL? {
        guard site == "YouTube" else {
            return nil
        }
        return URL(string: "https://www.youtube.com/watch?v=\(key)")
    }
}

extension MWMovie {
    var posterURL: URL? {
        guard let posterPath = posterPath else { return nil }
        return URL(string: posterPath)
    }
    var genres: [String] {
        return self.genreIds.map { (MWSys.sh.getGenreName(for: Int($0)) ?? "-") }
    }
}
