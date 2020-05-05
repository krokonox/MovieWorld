//
//  MWMainTabBarController.swift
//  MovieWorld
//
//  Created by Admin on 21/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class MWMainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBar()
    }
    
    func setupTabBar() {
        
        self.view.backgroundColor = .white
        self.tabBar.tintColor = UIColor(named: "RedColor")
        self.tabBar.barTintColor = .white
        
        let mainController = self.createNavigationController(MWMainViewController(), title: "main")
        let categoryController = self.createNavigationController(MWCategoryViewController(), title: "category")
        let searchController = self.createNavigationController(MWSearchViewController(), title: "search")

        self.viewControllers = [mainController, searchController, categoryController]
    }
    
    func createNavigationController(_ viewController: UIViewController, title: String) -> UINavigationController {
          let navController = UINavigationController(rootViewController: viewController)
          navController.tabBarItem.title = title
          navController.tabBarItem.image = UIImage(named: title)
          
          return navController
      }
}
