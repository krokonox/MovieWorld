//
//  MWConfiguration.swift
//  MovieWorld
//
//  Created by Admin on 06/03/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

public struct MWConfiguration {
    
    public static let baseURL = "https://image.tmdb.org/t/p/w185"
    public static let secureBaseURL = "https://image.tmdb.org/t/p/w500"
    
}


// -----------Work on this later!!!---------------

























//public struct Configuration: Decodable {
//    var images: Image
//}
//
//struct Image: Decodable {
//    var base_url: String
//    var secure_base_url: String
//    var logo_sizes: [ImageSizes]
//
//    enum ImageSizes: Decodable {
//        init(from decoder: Decoder) throws {
//            <#code#>
//        }
//        case w45, w92, w154, w185, w300, w500, original, unknown
//    }
//}
