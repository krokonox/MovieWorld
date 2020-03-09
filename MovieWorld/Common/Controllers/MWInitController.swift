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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadGenres()
        loadConfiguration()
        MWI.sh.setupTabBarController()
    }
    
    func loadGenres() { MWNet.sh.request(urlPath: "genre/movie/list",
                                         successHandler: { [weak self] (_ response: GenreResults) in
                                            MWSys.sh.setGenres(response.genres)
        },
                                         errorHandler: { [weak self] ( MWError ) in
                                            print(MWError.localizedDescription)})
    }
    
    func loadConfiguration() { MWNet.sh.request(urlPath: "configuration",
                                                successHandler: { [weak self] (_ response: MWConfiguration) in
                                                    MWSys.sh.setConfiguration(response.images)
        },
                                                errorHandler: { [weak self] ( MWError ) in
                                                    print(MWError.localizedDescription)})
    }
}
