//
//  AppDelegate.swift
//  CheckPlease
//
//  Created by Tony Cioara on 8/29/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        // TODO: set 'initialViewController' as 'navControllers' root when publishing app.
        let navController = UINavigationController(rootViewController: HomeViewController())
        navController.navigationBar.prefersLargeTitles = true
        navController.navigationBar.barTintColor = AppColors.white
        let initialViewController = isLoggedIn ? navController : LoginViewController()
        
        window = UIWindow()
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
        return true
    }
}
