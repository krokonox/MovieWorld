//
//  GenericCollectionViewCell.swift
//  MovieWorld
//
//  Created by Admin on 01/04/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

struct MWGenericCollectionViewCellModel {
    let image: String?
    let firstTitle: String
    let secondTitle: String
    let imageSize: Int
    
    init(movie: MWMovie) {
        self.image = movie.posterPath
        self.firstTitle = movie.title
        self.secondTitle = "\(movie.genres.map { $0 }.joined(separator: ", ")), \(movie.releaseDate)"
        self.imageSize = 185
    }
    
    init(cast: Cast) {
        self.image = cast.profile_path
        self.firstTitle = cast.name.components(separatedBy: " ")[1]
        self.secondTitle = cast.character
        self.imageSize = 92
    }
}
