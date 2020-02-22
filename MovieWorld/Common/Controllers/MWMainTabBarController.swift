//
//  MWMainTabBarController.swift
//  MovieWorld
//
//  Created by Admin on 21/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit

class MWMainTabBarController: UITabBarController {
    
    let viewController = [MainViewController(), SearchViewController(), CategoryViewController()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.viewControllers = viewController
//        self.viewControllers.map(UINavigationController(rootViewController: $0))
    }
}
