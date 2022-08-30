//
//  NewsPresenterTests.swift
//  mvpExampleTests
//
//  Created by Андрей Груненков on 30.08.2022.
//

import XCTest

class NewsPresenterTests: XCTestCase {
    
    var newsPresenter: NewsPresenter?

    override func setUpWithError() throws {
        let jsonData = """
        {
           "title": "test",
           "description": "test",
        }
        """.data(using: .utf8)!
        let article = try JSONDecoder().decode(Article.self, from: jsonData)
        newsPresenter = NewsPresenter(article: article)
    }

    override func tearDownWithError() throws {
        newsPresenter = nil
    }

    func testThanClaimArticleSuccess() throws {
        XCTAssertNoThrow(newsPresenter?.getArticle())
        XCTAssertNotNil(newsPresenter?.getArticle())
    }

}
