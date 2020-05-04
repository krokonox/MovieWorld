//
//  MWInterface.swift
//  MovieWorld
//
//  Created by Admin on 20/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

typealias MWI = MWInterface

class MWInterface {
    
    // MARK: - Variables
    
    static let sh = MWInterface()
    
    private weak var window: UIWindow?
    
    private lazy var tabBarController = MWMainTabBarController()
    private lazy var initController = MWInitController()
    
    // MARK: - Initialization
    
    private init() {}
    
    // MARK: - Functions
    
    func setup(window: UIWindow) {
        self.window = window
        self.setUpNavigationBarStyle()
        window.rootViewController = initController
        window.makeKeyAndVisible()
    }
    
    func setupTabBarController() {
        self.window?.rootViewController = self.tabBarController
    }
    
    private func setUpNavigationBarStyle() {
        let standartNavBar = UINavigationBar.appearance()
        standartNavBar.backgroundColor = .white
        standartNavBar.tintColor = .red
        standartNavBar.prefersLargeTitles = true
        standartNavBar.backItem?.title = " "
        
        if #available(iOS 13.0, *) {
            let newVavBar = UINavigationBarAppearance()
            newVavBar.configureWithDefaultBackground()
            newVavBar.configureWithDefaultBackground()
            standartNavBar.scrollEdgeAppearance = newVavBar
        } 
    }
    
    func push(vc: UIViewController) {
        guard let navigationController = self.tabBarController.selectedViewController as?
                                         UINavigationController else { return }
        navigationController.pushViewController(vc, animated: true)
    }
    
    func popVC() {
        guard let navigationController = self.tabBarController.selectedViewController as?
                                         UINavigationController else { return }
        navigationController.popViewController(animated: true)
    }
}
