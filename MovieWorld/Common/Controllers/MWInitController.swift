//
//  MWInitController.swift
//  MovieWorld
//
//  Created by Admin on 06/03/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import CoreData

class MWInitController: MWViewController {
    
    let dispatchGroup = DispatchGroup()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (MWCoreDataManager.sh.entityIsEmpty(entity: .GenreModel)) {
            self.loadGenres()
        }
        self.loadConfiguration()
        
        self.dispatchGroup.notify(queue: .main) { [weak self] in
            MWCoreDataManager.sh.fetchAllGenres()
            MWI.sh.setupTabBarController()
        }
    }
    
    // MARK: - Functions
    
    func loadGenres() {
        self.dispatchGroup.enter()
        MWNet.sh.request(urlPath: "genre/movie/list",
                         successHandler: { (_ response: GenreResults) in
                            response.genres.forEach { genre in
                                MWCoreDataManager.sh.saveGenre(genre: genre)
                            }
        },
                         errorHandler: { ( MWError ) in
                            print(MWError.localizedDescription)})
        self.dispatchGroup.leave()
    }
    
    func loadConfiguration() {
        self.dispatchGroup.enter()
        MWNet.sh.request(urlPath: "configuration",
                         successHandler: { (_ response: MWConfiguration) in
                            MWSys.sh.setConfiguration(response.images)
        },
                         errorHandler: {  ( MWError ) in
                            print(MWError.localizedDescription)})
        self.dispatchGroup.leave()
    }
}
