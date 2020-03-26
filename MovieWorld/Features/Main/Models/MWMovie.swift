//
//  MWMovie.swift
//  MovieWorld
//
//  Created by Admin on 25/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit

struct MWMovie: Decodable, Equatable {
//    var id: Int
    var title: String
    var genre_ids: [Int16]
    var release_date: String
    var poster_path: String?
    var vote_average: Double
//    var overview: String
}

extension MWMovie {
    public var posterURL: URL? {
        guard let poster_path = poster_path else { return nil }
        return URL(string: poster_path )
    }
    public var genres: [String] {
        return self.genre_ids.map { (MWSys.sh.getGenreName(for: Int($0)) ?? "-") }
    }
}
