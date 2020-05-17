//
//  MWCountry.swift
//  MovieWorld
//
//  Created by Admin on 11/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

struct Country: Decodable {
    let code: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case code = "iso_3166_1"
        case name = "english_name"
    }
}

struct CountryResults: Decodable {
    let countries: [Country]
}
