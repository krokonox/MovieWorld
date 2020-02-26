//
//  MWMovie.swift
//  MovieWorld
//
//  Created by Admin on 25/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit

struct MWMovie {
    
    var title: String
    var genre: String
    var year: Int
    var image: UIImage
    
    init(title: String, genre: String, year: Int, image: UIImage) {
        self.title = title
        self.year = year
        self.genre = genre
        self.image = image
    }
}
