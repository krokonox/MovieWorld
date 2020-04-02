//
//  GenericCollectionViewCell.swift
//  MovieWorld
//
//  Created by Admin on 01/04/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import Foundation

struct MWGenericCollectionViewCellModel: Equatable {
    let image: String?
    let firstTitle: String
    let secondTitle: String
    let imageSize: Int
    
    init(movie: MWMovie) {
        image = movie.poster_path
        firstTitle = movie.title
        secondTitle = "\(movie.genres.map { $0 }.joined(separator: ", ")), \(movie.release_date)"
        imageSize = 185
    }
    
    init(cast: Cast) {
        image = cast.profile_path
        firstTitle = cast.name.components(separatedBy: " ")[1]
        secondTitle = cast.character
        imageSize = 92
    }
}
