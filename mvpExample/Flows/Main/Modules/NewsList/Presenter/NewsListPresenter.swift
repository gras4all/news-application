//
//  NewsListPresenter.swift
//  mvpExample
//
//  Created by Андрей Груненков on 15.08.2022.
//

import UIKit

final class NewsListPresenter: NewsListPresenterProtocol {
    
    let defaultQuery = "news"
    
    weak var view: NewsListViewInConnection!
    
    var networkManager: NetworkManagerProtocol!
    
    var onSelectNews: SelectNewsClosure?
    
    private var articles: [Article] = []
    private var sort: SortKind = .date
    private var query: String?
    
    private var searchTimer: Timer?
    
    func selectNews(index: Int) {
        onSelectNews?(articles[index])
    }
    
    func requestNews(query: String, withDelay: Bool) {
        self.query = query
        if withDelay {
            searchTimer?.invalidate()
            searchTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(initLoad), userInfo: nil, repeats: false)
        } else {
            initLoad()
        }
    }
    
    func requestNews() {
        self.requestNews(query: defaultQuery, withDelay: false)
    }
    
    func sortSelected(kind: SortKind) {
        self.sort = kind
        view.showSort(kind: kind)
        initLoad()
    }
    
    func getNewsCount() -> Int {
        self.articles.count
    }
    
    func getCell(tableView: UITableView, index: Int) -> UITableViewCell {
        let article = articles[index]
        return NewsListCellFactory.buildNewsCell(tableView: tableView, article: article)
    }
    
}

//MARK: - private extensions
private extension NewsListPresenter {
    
    func fetchData(query: String, completion: @escaping (NewsResponse?, Error?) -> Void) {
        let request = NewsRequest(query: query, sortBy: sort)
        networkManager.executeRequest(request: request, completion: completion)
    }
    
    @objc func initLoad() {
        guard let query = query else { return }
        view.showLoader()
        self.fetchData(query: query, completion: { [weak self] response, error in
            guard let self = self else { return }
            self.view.hideLoader()
            if let response = response {
                self.articles = response.articles
                self.view.reloadTable()
            }
        })
    }
    
}


