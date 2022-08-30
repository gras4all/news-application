//
//  NewsListFactory.swift
//  mvpExample
//
//  Created by Андрей Груненков on 15.08.2022.
//

import Foundation
import UIKit

final class NewsListFactory {

    static func buildNewsListModule(onSelect: @escaping SelectNewsClosure) -> UIViewController {
        let vc = NewsListViewController()
        let presenter = NewsListPresenter()
        presenter.onSelectNews = onSelect
        vc.presenter = presenter
        presenter.view = vc
        presenter.networkManager = NetworkManager()
        return vc
    }

}
