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
    
    var movieGenres = MWSystem.sh.genres
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        loadGenres()
    }
    
    func loadGenres() { MWNet.sh.request(urlPath: "genre/movie/list",
                                         successHandler: { [weak self] (_ response: GenreResults) in
                                            self?.movieGenres = response.genres
        },
                                         errorHandler: { [weak self] ( MWError ) in
                                            print(MWError.localizedDescription)})
    }
}
