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
        window = UIWindow(frame: UIScreen.main.bounds)
        AppNavigator(window: window!)
        return true
    }

//    private final func setInitView() {
//        let controller = CurrencySelectorViewController()
//        controller.viewModel = CurrencySelectorListViewModel()
//        let navigationController = UINavigationController(rootViewController: controller)
//        window?.rootViewController = navigationController
//        window?.makeKeyAndVisible()
//    }
}
