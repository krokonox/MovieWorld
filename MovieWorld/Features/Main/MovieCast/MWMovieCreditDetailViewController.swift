//
//  MWMovieCreditDetail.swift
//  MovieWorld
//
//  Created by Admin on 10/04/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class MWMovieCreditDetailViewController: MWViewController {
    
    private let castId: Int
    var cast: Cast? {
        didSet {
            
        }
    }
    
    init(castId: Int) {
        self.castId = castId
        print("init")
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("didLoad")
        self.title = cast?.name
    }
    
    private func fetchCreditDetail() {
        
    }
}
