//
//  MWApiPaths.swift
//  MovieWorld
//
//  Created by Admin on 29/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

enum URLPaths: String, CaseIterable {
    case popular = "movie/popular"
    case latest = "movie/now_playing"
    case topRated = "movie/top_rated"
    case upcoming = "movie/upcoming"
    
    public var description: String {
        switch self {
        case .popular: return "Popular"
        case .latest: return "Latest"
        case .topRated: return "Top Rated"
        case .upcoming: return "Upcoming"
        }
    }
    
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

enum Endpoints {
    
    case getByGenreId(genreId: Int)
    case search
    case getDetail(id: Int)
    case getVideos(id: Int)
    case getCredits(id: Int)
    case getPersonDetail(id: Int)
    case getImage(size: Int, profilePath: String)
    case getMovieDiscover
}

extension Endpoints {
    var path : String {
        switch self {
        case .getByGenreId:
            return "discover/movie"
        case .search:
            return "search/movie"
        case .getDetail(let id):
            return "movie/\(id)"
        case .getVideos(let id):
            return "movie/\(id)/videos"
        case .getCredits(let id):
            return "movie/\(id)/credits"
        case .getPersonDetail(let id):
            return "person/\(id)"
        case .getImage(let id, let path):
            return "https://image.tmdb.org/t/p/w\(id)\(path)"
        case .getMovieDiscover:
            return "discover/movie"
        }
    }
}
