//
//  NetworkInterface.swift
//  MovieWorld
//
//  Created by Admin on 29/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import  UIKit

typealias MWNet = MWNetwork

class MWNetwork {
    
    static let sh = MWNetwork()
    
    private init() {}
    
    private let api_key = "79d5894567be5b76ab7434fc12879584"
    private let baseURL = "https://api.themoviedb.org/3/movie/"
    
    
}
