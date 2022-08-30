//
//  NewsPresenter.swift
//  mvpExample
//
//  Created by Андрей Груненков on 15.08.2022.
//

import Foundation

final class NewsPresenter: NewsPresenterProtocol {
    
    weak var view: NewsViewInConnection!
    
    var article: Article
    
    init(article: Article) {
        self.article = article
    }
    
    func getArticle() -> Article {
        article
    }
    
}

