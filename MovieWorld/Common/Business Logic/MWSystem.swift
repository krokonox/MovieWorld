//
//  MWSystem.swift
//  MovieWorld
//
//  Created by Admin on 06/03/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

typealias MWSys = MWSystem

class MWSystem {
    
    static let sh = MWSystem()
    
    var genres: [GenreModel] = []
    var countries: [CountryModel] = []
    var image: Image?
    
    private init() {}
    
    func setGenres(_ genres: [GenreModel]) {
        self.genres = genres
    }
    
    func setCountries(_ countries: [CountryModel]) {
        self.countries = countries
    }
    
    func setConfiguration(_ image: Image) {
        self.image = image
    }
    
    func getGenreName(for genreId: Int) -> String? {
        guard let genre = genres
            .filter({ $0.id == genreId })
            .first else { return nil }
        return genre.name
    }
    
    func getCountryName(for countryCode: String) -> String? {
        guard let country = countries
            .filter({ $0.code == countryCode })
            .first else { return nil }
        return country.name
    }
}
