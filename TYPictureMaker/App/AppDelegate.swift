//
//  AppDelegate.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/17.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let nav = UINavigationController(rootViewController: TYMainViewController())
        self.window!.rootViewController = nav
        self.window!.makeKeyAndVisible()
        
        return true
    }


}

