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
        nc.navigationBar.barTintColor = UIColor(red:0.94, green:0.32, blue:0.24, alpha:1.0)
        nc.navigationBar.tintColor = .white
        nc.navigationBar.barStyle = UIBarStyle.black
        nc.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        nc.navigationBar.shadowImage = UIImage()

        window?.rootViewController = nc
        window?.makeKeyAndVisible()
        return true
    }
}   

