//
//  MWCreditsResponse.swift
//  MovieWorld
//
//  Created by Admin on 10/04/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

struct MWCreditsResponse: Decodable {
    let cast: [Cast]
    let crew: [Crew]
}

struct Cast: Decodable {
    let cast_id: Int
    let character: String
    let id: Int
    let name: String
    let profile_path: String?
}

struct Crew: Decodable {
    let credit_id: String
    let id: Int
    let job: String
    let department: String
    let name: String
    let profile_path: String?
}
