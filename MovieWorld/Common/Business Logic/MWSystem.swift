//
//  MWSystem.swift
//  MovieWorld
//
//  Created by Admin on 06/03/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

class MWSystem {
    
    let session: URLSession
    
    init() {
        self.session = URLSession()
    }
    
    func loadGenres(successHandler: @escaping(_ response: GenreResults) -> Void, errorHandler: @escaping(Error) -> Void) {
        MWNet.sh.request(urlPath: "/list",successHandler: { [weak self] (_ response: GenreResults) in
            MWGenreHelper.sh.genres = response.genres
        }) { [weak self] (error) in
            print(error.localizedDescription)
        }
    }
}

