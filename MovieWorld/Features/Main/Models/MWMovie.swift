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
    var title: String
    var genre_ids: [Int]
    var release_date: String
    var poster_path: String?
}

extension MWMovie {
    public var posterURL: URL? {
        guard let poster_path = poster_path else { return nil }
        return URL(string: poster_path )
    }
}
