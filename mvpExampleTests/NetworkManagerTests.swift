//
//  networkManagerTests.swift
//  mvpExampleTests
//
//  Created by Андрей Груненков on 23.08.2022.
//

import XCTest

struct StubTestRequest: Requestable {
    
    var method: HTTPMethod = .get
    
    var query: String
    var sortBy: String
    
    enum CodingKeys: String, CodingKey {
        case query = "q"
        case sortBy
    }
    
    func encode(to encoder: Encoder) throws {
        var rootContainer = encoder.container(keyedBy: CodingKeys.self)
        try rootContainer.encode(query, forKey: .query)
        try rootContainer.encode(sortBy, forKey: .sortBy)
    }
    
}

struct DummyResponse: Decodable {
    
    var articles: [Article]
    
    enum CodingKeys: String, CodingKey {
        case articles
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.articles = try container.decode([Article].self, forKey: .articles)
    }
    
}

class NetworkManagerTests: XCTestCase {
    
    var networkManager: NetworkManager?

    override func setUpWithError() throws {
        networkManager = NetworkManager()
    }

    override func tearDownWithError() throws {
        networkManager = nil
    }

    func testThanRequestCompletedSuccess() throws {
        
        let requestExpectation = expectation(description: "Request Expectation")
        let request = StubTestRequest(query: "apple", sortBy: "popularity")
        var isRequestSuccessCompleted = false
        let completion: (DummyResponse?, Error?) -> Void = { response, error in
            if error == nil {
                isRequestSuccessCompleted = true
            }
            requestExpectation.fulfill()
        }
        
        networkManager?.executeRequest(request: request, completion: completion)
        wait(for: [requestExpectation], timeout: 5.0)
        
        XCTAssertTrue(isRequestSuccessCompleted, "Request success completed")
        
    }

}
