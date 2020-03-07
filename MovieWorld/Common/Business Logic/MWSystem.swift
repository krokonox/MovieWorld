//
//  MWSystem.swift
//  MovieWorld
//
//  Created by Admin on 06/03/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit

class MWSystem: UIViewController {
    
    let session: URLSession
    
    func loadGenres() {
        MWNet.sh.request(urlPath: "/list", successHandler: { [weak self] (_ response: GenreResults) in
            MWGenreHelper.sh.genres = response.genres
            }, errorHandler: { [weak self] ( MWError ) in
                print(MWError.localizedDescription)})
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadGenres()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

