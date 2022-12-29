//
//  AppDelegate.swift
//  AIApp
//
//  Created by Max Xaker on 29.12.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = OnboardingViewController()
        window?.makeKeyAndVisible()
        
        return true
    }


}

