//
//  routerTests.swift
//  mvpExampleTests
//
//  Created by Андрей Груненков on 22.08.2022.
//

import XCTest

class DummyModule: Presentable {
    var toPresent: UIViewController?
    
    init() {
        toPresent = UIViewController()
    }
}

class RouterTests: XCTestCase {
    
    var router: Router?

    override func setUpWithError() throws {
        router = Router(rootController: UINavigationController())
    }

    override func tearDownWithError() throws {
        router = nil
    }

    func testThanPushPerformSuccess() throws {
        
        let testModule = DummyModule()
        
        XCTAssertNoThrow(router?.push(testModule), "Push perform success")
        
    }
    
    func testThanPresentPerformSuccess() throws {
        
        let testModule = DummyModule()
        
        XCTAssertNoThrow(router?.present(testModule), "Present perform success")
        
    }

}
