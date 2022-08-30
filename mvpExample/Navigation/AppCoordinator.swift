//
//  AppCoordinator.swift
//  mvpExample
//
//  Created by Андрей Груненков on 15.08.2022.
//

import Foundation

fileprivate enum LaunchInstructor {
    case main
        
    static func setup() -> LaunchInstructor {
        return .main
    }
}

final class AppCoordinator: BaseCoordinator {
    
    fileprivate let factory: CoordinatorFactoryProtocol
    fileprivate let router : Routable
    
    fileprivate var instructor: LaunchInstructor {
        return LaunchInstructor.setup()
    }
    
    init(router: Routable, factory: CoordinatorFactoryProtocol) {
        self.router  = router
        self.factory = factory
    }
}

// MARK:- Coordinatable
extension AppCoordinator: Coordinatable {
    func start() {
        switch instructor {
        case .main:
            performMainFlow()
        }
    }
}

// MARK:- Private methods
private extension AppCoordinator {
    
    func performMainFlow() {
        let coordinator = factory.makeMainCoordinator(router: router)
        coordinator.finishFlow = { [unowned self, unowned coordinator] in
            self.start()
            self.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
}
