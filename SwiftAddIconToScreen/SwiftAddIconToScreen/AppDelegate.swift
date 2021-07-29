//
//  AppDelegate.swift
//  SwiftAddIconToScreen
//
//  Created by chenyu on 2021/7/29.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.rootViewController = ViewController()
        return true
    }

    
    //
    func applicationWillResignActive(_ application: UIApplication) {
        UIApplication.shared.beginBackgroundTask {
            
        }
    }


}

