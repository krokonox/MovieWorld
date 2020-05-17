//
//  MWMovieCast.swift
//  MovieWorld
//
//  Created by Admin on 01/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

struct MWCreditsResponse: Decodable {
    var movieCast: [Credit]
}

struct Credit: Decodable {
    var id: Int?
    var cast: [Cast]
    var crew: [Crew]
}

struct Cast: Decodable {
    let cast_id: Int
    let character: String
    let id: Int
    let name: String
    let profile_path: String?
}

struct Crew: Decodable {
    var department: String
    var id: Int
    var job: String
    var name: String?
}

