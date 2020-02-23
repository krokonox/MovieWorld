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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
    }
    
    func setupTabBar() {
        
        self.view.backgroundColor = .white
        self.tabBar.tintColor = UIColor(named: "RedColor")
        self.tabBar.barTintColor = .white
        
        let mainController = createNavigationController(MainViewController(), title: "main")
        let categoryController = createNavigationController(CategoryViewController(), title: "category")
        let searchController = createNavigationController(SearchViewController(), title: "search")

        viewControllers = [mainController, searchController, categoryController]
    }
    
    func createNavigationController(_ viewController: UIViewController, title: String) -> UINavigationController {
          let navController = UINavigationController(rootViewController: viewController)
          navController.tabBarItem.title = title
          navController.tabBarItem.image = UIImage(named: title)
          
          return navController
      }
}
