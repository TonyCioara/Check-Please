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
        let initialViewController = isLoggedIn ? HomeViewController() : LoginViewController()
        // TODO: set 'initialViewController' as 'navControllers' root when publishing app.
        let navController = UINavigationController(rootViewController: LoginViewController())
        navController.navigationBar.prefersLargeTitles = true
        navController.navigationBar.barTintColor = AppColors.white
        
        window = UIWindow()
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        return true
    }
}
