//
//  AppDelegate.swift
//  BookStore_JoaoGomes
//
//  Created by João Gomes on 27/11/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate
{    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool
    {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // type storyboard name instead of Main
        if let viewController = storyboard.instantiateViewController(withIdentifier: "ListViewController") as? ListViewController
        {
            window?.rootViewController = NavigationController(rootViewController: viewController)
        }
        
        
        return true
    }

}

