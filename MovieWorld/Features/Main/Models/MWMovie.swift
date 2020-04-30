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
    var genre_ids: [Int16]
    var release_date: String
    var poster_path: String?
    var vote_average: Double
    var overview: String
    var videos: MWMovieVideoResponse?
    
    static func == (lhs: MWMovie, rhs: MWMovie) -> Bool {
        return false
    }
}

struct MWMovieVideoResponse: Codable {
    let results: [MovieVideo]
}

struct MovieVideo: Codable {
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
        guard let poster_path = poster_path else { return nil }
        return URL(string: poster_path )
    }
    var genres: [String] {
        return self.genre_ids.map { (MWSys.sh.getGenreName(for: Int($0)) ?? "-") }
    }
}
