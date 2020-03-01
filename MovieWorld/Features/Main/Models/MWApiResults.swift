//
//  MWApiResults.swift
//  MovieWorld
//
//  Created by Admin on 29/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

struct MWApiResults: Decodable {
    
    let page: Int
    let total_results: Int
    let total_pages: Int
    let results: [MWMovie]
}
