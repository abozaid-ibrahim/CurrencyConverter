//
//  AppDelegate.swift
//  CurrencyConverter
//
//  Created by Abuzeid on 1/1/20.
//  Copyright © 2020 Abuzeid. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
//http://data.fixer.io/api/latest?access_key=753bfb556035f3badde59b452263f708&format=1&base=EUR
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
         window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = CurrencySelectorViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
}
