//
//  Error.swift
//  MovieWorld
//
//  Created by Admin on 29/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

public enum MWEroor: Error {
    case incorrectUrl
    case networkError
    case serverError
    case parsingError
    
    case unknown
}
