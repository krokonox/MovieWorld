//
//  SearchViewController.swift
//  MovieWorld
//
//  Created by Admin on 20/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class MWSearchViewController: MWViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Search".localized
        MWI.sh.push(vc: UIViewController())
    }
}
