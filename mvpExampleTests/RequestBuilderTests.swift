//
//  requestBuilderTests.swift
//  mvpExampleTests
//
//  Created by Андрей Груненков on 23.08.2022.
//

import XCTest

struct StubRequest: Encodable {
    
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

class RequestBuilderTests: XCTestCase {

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func testThanRequestCreatedSuccess() throws {
        
        let stubRequest = StubRequest(query: "test", sortBy: "byPopular")
        
        let request = RequestBuilder.buildRequest(params: stubRequest)
        
        XCTAssertNotNil(request, "Request successfully created")
    }
    
    func testThanRequestIsGetRequest() throws {
        
        let stubRequest = StubRequest(query: "test", sortBy: "byPopular")
        var methodIsGet = false
        
        if let request = RequestBuilder.buildRequest(params: stubRequest),
           let method = request.httpMethod {
            methodIsGet = (method == HTTPMethod.get.rawValue)
        }
        
        XCTAssertTrue(methodIsGet, "Method is GET")
    }

}
