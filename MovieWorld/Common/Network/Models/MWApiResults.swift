//
//  MWApiResults.swift
//  MovieWorld
//
//  Created by Admin on 29/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

struct MWApiResults: Decodable {
    let page: Int?
    let totalResults: Int?
    let totalPages: Int?
    let results: [MWMovie]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}
