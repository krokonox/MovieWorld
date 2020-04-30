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
    // Return localized error message
    var description: String {
        switch self {
        case .incorrectUrl:
            return ErrorMessages.Default.incorrectUrl
        case .serverError:
            return ErrorMessages.Default.serverError
        case .networkError:
            return ErrorMessages.Default.networkError
        case .parsingError:
            return ErrorMessages.Default.parsingError
        default:
            return ErrorMessages.Default.unknownError
        }
    }
}

 // delete this
extension MWError {
    
    struct ErrorMessages {
        
        struct Default {
            static let serverError = "Server Error. Please, try again later."
            static let parsingError = "Failed to decode data, try again."
            static let incorrectUrl = "You have entered the wrong URL, try another one."
            static let networkError = "Failed to connect. Please, try again later."
            static let unknownError = "Something went wrong, try again later."
        }
    }  
}
