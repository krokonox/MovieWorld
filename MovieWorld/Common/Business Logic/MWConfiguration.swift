//
//  MWConfiguration.swift
//  MovieWorld
//
//  Created by Admin on 06/03/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

struct MWConfiguration: Decodable {
    var images: Image
}

struct Image: Decodable {
    var base_url: String
    var secure_base_url: String
    var logo_sizes: [ImageSizes]
    
    enum ImageSizes: String, Decodable {
        case w45, w92, w154, w185, w300, w500, original, unknown
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            self = try ImageSizes(rawValue: (container.decode(RawValue.self))) ?? .unknown
        }
    }
}
