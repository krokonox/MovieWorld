//
//  MWGenreHelper.swift
//  MovieWorld
//
//  Created by Admin on 07/03/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

class MWCategories {
   
    var genres: [Genre] = []
    
    func setGenres(_ genres: [Genre]) {
        self.genres = genres
    }
    
    func getGenreName(for genreId: Int) -> String? {
        guard let genre = genres.filter({ $0.id == genreId }).first else { return nil }
        return genre.name
    }
}

