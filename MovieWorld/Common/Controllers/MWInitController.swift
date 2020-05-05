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
    let dispatchGroup = DispatchGroup()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if MWCoreDataManager.sh.entityIsEmpty(entity: .GenreModel) {
            self.loadGenres()
        }
        self.loadConfiguration()
        self.dispatchGroup.notify(queue: .main) {
            MWCoreDataManager.sh.fetchAllGenres()
            MWI.sh.setupTabBarController()
        }
    }
    
    // MARK: - Functions
    
    func loadGenres() {
        self.dispatchGroup.enter()
        MWNet.sh.request(urlPath: self.genreURL,
                         successHandler: { (_ response: GenreResults) in
                            response.genres.forEach { genre in
                                MWCoreDataManager.sh.saveGenre(genre: genre)
                                self.dispatchGroup.leave()
                            }
        },
                         errorHandler: { ( MWError ) in
                            print(MWError.localizedDescription)
                            self.dispatchGroup.leave()
        })
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
}
