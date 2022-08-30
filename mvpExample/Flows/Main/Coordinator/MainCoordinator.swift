//
//  MainCoordinator.swift
//  mvpExample
//
//  Created by Андрей Груненков on 16.08.2022.
//

import Foundation

final class MainCoordinator: BaseCoordinator, MainCoordinatorOutput {
    
    var finishFlow: CompletionBlock?
    
    fileprivate let router : Routable
    
    init(router: Routable) {
        self.router  = router
    }
}

// MARK:- Coordinatable
extension MainCoordinator: Coordinatable {
    func start() {
        performFlow()
    }
}

// MARK:- Private methods
private extension MainCoordinator {
    func performFlow() {
        let view = NewsListFactory.buildNewsListModule { [weak self] article in
            guard let self = self else { return }
            let view = NewsFactory.buildNewsModule(article: article)
            self.router.push(view)
        }
        router.setRootModule(view, hideBar: false)
    }
}
