//
//  MWInitController.swift
//  MovieWorld
//
//  Created by Admin on 06/03/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit

class MWInitController: UIViewController {
    
    let dispatchGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    
        self.loadGenres()
        self.loadConfiguration()
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            MWI.sh.setupTabBarController()
        }
    }
    
    func loadGenres() {
        dispatchGroup.enter()
        MWNet.sh.request(urlPath: "genre/movie/list",
                         successHandler: { [weak self] (_ response: GenreResults) in
                            MWSys.sh.setGenres(response.genres)
                            print(response.genres)
            },
                         errorHandler: { [weak self] ( MWError ) in
                            print(MWError.localizedDescription)})
       dispatchGroup.leave()
    }
    
    func loadConfiguration() {
        dispatchGroup.enter()
        MWNet.sh.request(urlPath: "configuration",
                         successHandler: { [weak self] (_ response: MWConfiguration) in
                            MWSys.sh.setConfiguration(response.images)
            },
                         errorHandler: { [weak self] ( MWError ) in
                            print(MWError.localizedDescription)})
        dispatchGroup.leave()
        
    }
}
