//
//  MWInitController.swift
//  MovieWorld
//
//  Created by Admin on 06/03/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class MWInitController: MWViewController {
    
    // MARK: - Variables
    
    let genreURL = "genre/movie/list"
    let configURL = "configuration"
    let countryURL = "configuration/countries"
    
    let dispatchGroup = DispatchGroup()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if MWCoreDataManager.sh.entityIsEmpty(entity: .GenreModel) {
            self.loadGenres()
        }
        if MWCoreDataManager.sh.entityIsEmpty(entity: .CountryModel) {
            self.loadCountries()
        }
     
        MWCoreDataManager.sh.fetchAllGenres()
        MWCoreDataManager.sh.fetchAllCountries()
        
        MWI.sh.setupTabBarController()
        
    }
    
    // MARK: - Functions
    
    func loadGenres() {
        self.dispatchGroup.enter()
        MWNet.sh.request(urlPath: self.genreURL,
                         successHandler: { [weak self] (_ response: GenreResults) in
                            response.genres.forEach { genre in
                                MWCoreDataManager.sh.saveGenre(genre: genre)
                            }
                            self?.dispatchGroup.leave()
        }) { [weak self] ( MWError ) in
                            print(MWError.localizedDescription)
                            self?.dispatchGroup.leave()
        }
    }
    
    func loadConfiguration() {
        self.dispatchGroup.enter()
        MWNet.sh.request(urlPath: self.configURL,
                         successHandler: { (_ response: MWConfiguration) in
                            MWSys.sh.setConfiguration(response.images)
                            self.dispatchGroup.leave()
        },
                         errorHandler: {  ( MWError ) in
                            print(MWError.localizedDescription)
                            self.dispatchGroup.leave()
        })
    }
    
    func loadCountries() {
        self.dispatchGroup.enter()
        MWNet.sh.request(urlPath: self.countryURL,
                         successHandler: { [weak self] (_ response: [Country]) in
                            response.forEach { country in
                                MWCoreDataManager.sh.saveCountry(country: country)
                            }
                            self?.dispatchGroup.leave()
            })
        {[weak self] ( MWError ) in
            print(MWError.localizedDescription)
            self?.dispatchGroup.leave()
        }
    }
}
