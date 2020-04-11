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

extension MWError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .serverError:
            return ErrorMessages.Default.serverError
        case .networkError:
            return ErrorMessages.Default.networkError
        case .incorrectUrl, .unknown:
            return ErrorMessages.Default.incorrectUrl
        case .parsingError:
            return ErrorMessages.Default.parsingError
    }
  }
}
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
