//
//  MWGenre.swift
//  MovieWorld
//
//  Created by Admin on 06/03/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

public struct Genre: Decodable {
    let id: Int
    let name: String
}

struct GenreResults: Decodable {
    let genres: [Genre]
}
