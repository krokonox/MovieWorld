//
//  AppDelegate.swift
//  MovieWorld
//
//  Created by Admin on 15/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import SnapKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let frame = UIScreen.main.bounds
        window = UIWindow(frame: frame)
        if let window = window {
            MWI.sh.setup(window: window)
        }
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        MWCoreDataManager.sh.saveContext()
    }
}
