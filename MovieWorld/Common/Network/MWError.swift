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
            return NSLocalizedString("You have entered the wrong URL, try another one.",
                                     comment: "")
        case .serverError:
            return NSLocalizedString("Server Error. Please, try again later.",
                                     comment: "")
        case .networkError:
            return NSLocalizedString("Failed to connect. Please, try again later.",
                                     comment: "")
        case .parsingError:
            return NSLocalizedString("Failed to decode data, try again.",
                                     comment: "")
        default:
            return NSLocalizedString("Something went wrong, try again later.",
                                     comment: "")
        }
    }
}
