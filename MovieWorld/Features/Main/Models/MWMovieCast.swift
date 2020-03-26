//
//  MWMovieCast.swift
//  MovieWorld
//
//  Created by Admin on 26/03/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

struct MWMovieCast {
    var id: Int
    var cast: [Cast]
}

struct Cast {
    var cast_id: Int
    var charachter: String
    var credit_id: String
    var gender: Int
    var id: Int
    var name: String
    var order: Int
    var profile_path: String
}
