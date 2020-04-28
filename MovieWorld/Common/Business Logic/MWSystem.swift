//
//  MWSystem.swift
//  MovieWorld
//
//  Created by Admin on 06/03/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import CoreData

typealias MWSys = MWSystem

class MWSystem {
    
    static let sh = MWSystem()
    
    var genres: [GenreModel] = []
    var image: Image?
    
    private init() {}
    
    func setGenres(_ genres: [GenreModel]) {
        self.genres = genres
    }
    
    func setConfiguration(_ image: Image) {
        self.image = image
    }
    
    func getGenreName(for genreId: Int) -> String? {
        guard let genre = genres.filter({ $0.id == genreId }).first else { return nil }
        return genre.name
    }
}
