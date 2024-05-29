//
//  AppDelegate.swift
//  Exercise2-NoteApp
//
//  Created by Panha on 5/21/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let account = AccountService.getAccountInfo()
        var rootVC: UIViewController!
        if account == nil {
            rootVC =  LoginViewController()
        }else{
            rootVC = TabBarViewController()
        }
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        return true
    }

    // MARK: UISceneSession Lifecycle

    

}

