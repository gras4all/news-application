//
//  CoordinatorFactory.swift
//  mvpExample
//
//  Created by Андрей Груненков on 16.08.2022.
//

import UIKit

final class CoordinatorFactory {}

// MARK:- CoordinatorFactoryProtocol
extension CoordinatorFactory: CoordinatorFactoryProtocol {
    func makeMainCoordinator(router: Routable) -> Coordinatable & MainCoordinatorOutput {
        return MainCoordinator(router: router)
    }
}

// MARK:- Private methods
private extension CoordinatorFactory {
    
    func router(_ navController: UINavigationController?) -> Routable {
        return Router(rootController: navController!)
    }
    
    /*func navigationController(_ navController: UINavigationController?, in storyboard: Storyboards) -> UINavigationController {
        return navController == nil ? UINavigationController.controllerFromStoryboard(storyboard) : navController!
    }*/
}



