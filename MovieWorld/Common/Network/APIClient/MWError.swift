//
//  Error.swift
//  MovieWorld
//
//  Created by Admin on 29/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

enum MWError: Error, LocalizedError {
    case incorrectUrl
    case networkError
    case serverError
    case parsingError
    case unknown
    
    var description: String {
        switch self {
        case .incorrectUrl:
            return ("You have entered the wrong URL, try another one.").localized
        case .serverError:
            return ("Server Error. Please, try again later.").localized
                                     
        case .networkError:
            return ("Failed to connect. Please, try again later.").localized
                                     
        case .parsingError:
            return ("Failed to decode data, try again.").localized
        default:
            return ("Something went wrong, try again later.").localized
        }
    }
}
