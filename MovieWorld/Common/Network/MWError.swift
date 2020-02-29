//
//  Error.swift
//  MovieWorld
//
//  Created by Admin on 29/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

enum MWEroor {
    case incorrectUrl(url: String)
    case networkError(error: Error)
    case serverError(error: Error)
    case parsingError(error: Error)
    
    case unknown
}
