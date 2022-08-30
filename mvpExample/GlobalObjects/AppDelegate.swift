//
//  AppDelegate.swift
//  mvpExample
//
//  Created by Андрей Груненков on 15.08.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var rootController: UINavigationController {
        window?.rootViewController = UINavigationController()
        return window?.rootViewController as! UINavigationController
    }
    
    fileprivate lazy var coordinator: Coordinatable = self.makeCoordinator()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        coordinator.start()
        return true
    }

}

// MARK:- Private methods
private extension AppDelegate {
    func makeCoordinator() -> Coordinatable {
        return AppCoordinator(router: Router(rootController: rootController),
                              factory: CoordinatorFactory())
    }
}

