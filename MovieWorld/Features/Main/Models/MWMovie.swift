//
//  MWMovie.swift
//  MovieWorld
//
//  Created by Admin on 25/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit

struct MWMovie: Decodable {
    
    var title: String
    var genre_ids: [Int]
    var release_date: String
    var poster_path: String?
}
