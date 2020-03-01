//
//  MWApiPaths.swift
//  MovieWorld
//
//  Created by Admin on 29/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

public enum URLPaths: String, CaseIterable {
    case popular = "movie/popular"
    case latest = "movie/now_playing"
    case topRated = "movie/top_rated"
    case upcoming = "movie/upcoming"
    
//    public var description: String {
//        switch self {
//        case .popular: return "Popular"
//        case .latest: return "Latest"
//        case .topRated: return "Top Rated"
//        case .upcoming: return "Upcoming"
//        }
//    }
    
    public init?(index: Int) {
        switch index {
        case 0: self = .popular
        case 1: self = .latest
        case 2: self = .topRated
        case 3: self = .upcoming
        default: return nil
        }
    }
}
