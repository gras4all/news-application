//
//  newsListPresenterTests.swift
//  mvpExampleTests
//
//  Created by Андрей Груненков on 22.08.2022.
//

import XCTest

class NewsListSpyView: NewsListViewInConnection {
    
    var showSortCount: Int = 0
    var reloadTableCount: Int = 0
    var showLoaderCount: Int = 0
    var hideLoaderCount: Int = 0
    
    func showSort(kind: SortKind) {
        showSortCount += 1
    }
    
    func reloadTable() {
        reloadTableCount += 1
    }
    
    func showLoader() {
        showLoaderCount += 1
    }
    
    func hideLoader() {
        hideLoaderCount += 1
    }
}

class StubNetworkManager: NetworkManagerProtocol {
    
    func executeRequest<T>(request: Requestable, completion: @escaping (T?, Error?) -> Void) where T : Decodable {
        do {
            let jsonData = """
            {
               "articles":  []
            }
            """.data(using: .utf8)!
            let decoded = try JSONDecoder().decode(NewsResponse.self, from: jsonData)
            completion(decoded as? T, nil)
        } catch _ {
            completion(nil, nil)
        }
    }
    
}

class NewsListPresenterTests: XCTestCase {
    
    var newsListDummyView: NewsListSpyView?
    var newsListPresenter: NewsListPresenter?
    var networkManager: NetworkManagerProtocol?
    
    override func setUpWithError() throws {
        newsListDummyView = NewsListSpyView()
        newsListPresenter = NewsListPresenter()
        newsListPresenter?.view = newsListDummyView
        newsListPresenter?.networkManager = StubNetworkManager()
    }

    override func tearDownWithError() throws {
        newsListDummyView = nil
        networkManager = nil
        newsListPresenter = nil
    }
    
    func testThanHandleLoadNewsCompleteSuccess() {
        newsListPresenter?.requestNews()
        
        XCTAssertEqual(newsListDummyView?.hideLoaderCount, 1)
        XCTAssertEqual(newsListDummyView?.showLoaderCount, 1)
        XCTAssertEqual(newsListDummyView?.reloadTableCount, 1)
    }
    
    func testThanSelectSortKindSuccess() {
        newsListPresenter?.sortSelected(kind: .popular)
        
        XCTAssertEqual(newsListDummyView?.showSortCount, 1)
    }
    
}
