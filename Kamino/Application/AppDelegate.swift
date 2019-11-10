//
//  AppDelegate.swift
//  Kamino
//
//  Created by Sandi Mihelic on 10/11/2019.
//  Copyright © 2019 Sandi Mihelic. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let vc = HomeVC()
        let navigation = UINavigationController(rootViewController: vc)
        navigation.setNavigationBarHidden(true, animated: false)
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        return true
    }
}

