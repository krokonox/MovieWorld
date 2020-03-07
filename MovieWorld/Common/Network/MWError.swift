//
//  Error.swift
//  MovieWorld
//
//  Created by Admin on 29/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

public enum MWError: Error {
    case incorrectUrl
    case networkError
    case serverError
    case parsingError
    
    case unknown
    
    var description: String {
        switch self {
        case .incorrectUrl:
            return ErrorMessages.Default.IncorrectUrl
        case .serverError:
            return ErrorMessages.Default.ServerError
        case .networkError:
            return ErrorMessages.Default.NetworkError
        case .parsingError:
            return ErrorMessages.Default.ParsingError
        default:
            return ErrorMessages.Default.UnknownError
        }
    }
}

extension MWError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .serverError:
            return ErrorMessages.Default.ServerError
        case .networkError:
            return ErrorMessages.Default.NetworkError
        case .incorrectUrl, .unknown:
            return ErrorMessages.Default.IncorrectUrl
        case .parsingError:
            return ErrorMessages.Default.ParsingError
    }
  }
}
extension MWError {
    
    struct ErrorMessages {
        
        struct Default {
            static let ServerError = "Server Error. Please, try again later."
            static let ParsingError = "Failed to decode data, try again."
            static let IncorrectUrl = "You have entered the wrong URL, try another one."
            static let NetworkError = "Failed to connect. Please, try again later."
            static let UnknownError = "Something went wrong, try again later."
        }
        
    }
    
}
