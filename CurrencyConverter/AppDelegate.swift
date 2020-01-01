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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setInitView()
        return true
    }

    private final func setInitView() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = CurrencySelectorViewController()
        vc.viewModel = CurrencySelectorListViewModel()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
}
