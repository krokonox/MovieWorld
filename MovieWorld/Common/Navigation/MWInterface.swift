//
//  MWInterface.swift
//  MovieWorld
//
//  Created by Admin on 20/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit

typealias MWI = MWInterface

class MWInterface {
    
    static let sh = MWInterface()
    
    weak var window: UIWindow?
    
    private lazy var tabBarController = MWMainTabBarController()
    
    private init() {}

    func setup(window: UIWindow) {
        
        self.window = window
        
        self.setUpNavigationBarStyle()
        
        window.rootViewController = self.tabBarController
        window.makeKeyAndVisible()
    }
    
    private func setUpNavigationBarStyle() {
        let standartNavBar = UINavigationBar.appearance()
        standartNavBar.backgroundColor = .white
        standartNavBar.tintColor = .red
        standartNavBar.prefersLargeTitles = true
        
        if #available(iOS 13.0, *) {
            let newVavBar = UINavigationBarAppearance()
            newVavBar.configureWithDefaultBackground()
            newVavBar.configureWithDefaultBackground()
            standartNavBar.scrollEdgeAppearance = newVavBar
        } else {
            // Fallback on earlier versions
        }
    }
    
    func push(vc: UIViewController) {
        guard let navigationController = self.tabBarController.selectedViewController as? UINavigationController else { return }
        navigationController.pushViewController(vc, animated: true)
    }
    
    func popVC() {
        guard let navigationController = self.tabBarController.selectedViewController as? UINavigationController else { return }
        navigationController.popViewController(animated: true)
    }
}
