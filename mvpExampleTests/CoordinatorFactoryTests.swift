//
//  coordinatorFactoryTests.swift
//  mvpExampleTests
//
//  Created by Андрей Груненков on 22.08.2022.
//

import XCTest

class CoordinatorFactoryTests: XCTestCase {
    
    var coordinatorFactory: CoordinatorFactory?

    override func setUpWithError() throws {
        coordinatorFactory = CoordinatorFactory()
    }

    override func tearDownWithError() throws {
        coordinatorFactory = nil
    }

    func testThanMainCoordinatorCreatedSuccess() throws {
        
        let dummyRouter = DummyRouter()
        var isMainCoordinatorCreated = false
        
        if coordinatorFactory?.makeMainCoordinator(router: dummyRouter) != nil {
            isMainCoordinatorCreated = true
        }
        
        XCTAssertTrue(isMainCoordinatorCreated, "Main Coordinator Success Created")
    }

}
