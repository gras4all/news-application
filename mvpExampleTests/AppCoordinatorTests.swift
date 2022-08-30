//
//  appCoordinatorTests.swift
//  appCoordinatorTests
//
//  Created by Андрей Груненков on 22.08.2022.
//

import XCTest

class DummyCoordinator: Coordinatable, MainCoordinatorOutput {
    
    func start() {}
    
    var finishFlow: CompletionBlock?
    
}

class DummyRouter: Routable {
    func present(_ module: Presentable?) {}
    
    func present(_ module: Presentable?, animated: Bool) {}
    
    func push(_ module: Presentable?) {}
    
    func push(_ module: Presentable?, animated: Bool) {}
    
    func push(_ module: Presentable?, animated: Bool, completion: CompletionBlock?) {}
    
    func popModule() {}
    
    func popModule(animated: Bool) {}
    
    func dismissModule() {}
    
    func dismissModule(animated: Bool, completion: CompletionBlock?) {}
    
    func setRootModule(_ module: Presentable?) {}
    
    func setRootModule(_ module: Presentable?, hideBar: Bool) {}
    
    func popToRootModule(animated: Bool) {}
    
    var toPresent: UIViewController?
}

class StubCoordinatorFactory: CoordinatorFactoryProtocol {
    
    func makeMainCoordinator(router: Routable) -> Coordinatable & MainCoordinatorOutput {
        DummyCoordinator()
    }
    
}

class AppCoordinatorTests: XCTestCase {
    
    var stubCoordinatorFactory: CoordinatorFactoryProtocol?
    
    var dummyRouter: Routable?
    
    var coordinator: AppCoordinator?

    override func setUpWithError() throws {
        stubCoordinatorFactory = StubCoordinatorFactory()
        dummyRouter = DummyRouter()
        coordinator = AppCoordinator(router: dummyRouter!, factory: stubCoordinatorFactory!)
    }

    override func tearDownWithError() throws {
        coordinator = nil
        stubCoordinatorFactory = nil
        dummyRouter = nil
    }

    func testThanMainFlowPerformSuccess() throws {
        coordinator?.start()
        
        XCTAssertTrue(coordinator!.childCoordinators.count > 0, "Main flow perform success")
    }

}
