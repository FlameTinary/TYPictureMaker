//
//  AppDelegate.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/17.
//

import UIKit
import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let nav = UINavigationController(rootViewController: TYMainViewController())
//        let nav = UINavigationController(rootViewController: UIHostingController(rootView: ShowPreview()))
        self.window!.rootViewController = nav
        self.window!.makeKeyAndVisible()

// 这里需要根据系统版本来调整nav
//        UINavigationBar.appearance().tintColor = backgroundColor
//        UINavigationBar.appearance().barTintColor = backgroundColor
//        UINavigationBar.appearance().isTranslucent = true
//        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : backgroundColor ?? .white]
        
        return true
    }


}

