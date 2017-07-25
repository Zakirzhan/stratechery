//
//  AppDelegate.swift
//  stratechery
//
//  Created by macbook on 13.07.17.
//  Copyright © 2017 zaka. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootViewController = ViewController()
        let nc = UINavigationController(rootViewController: rootViewController)
        nc.navigationBar.isTranslucent = false 
        window?.rootViewController = nc
        window?.makeKeyAndVisible()
        return true
    }
}

