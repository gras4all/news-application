//
//  NewsFactory.swift
//  mvpExample
//
//  Created by Андрей Груненков on 15.08.2022.
//

import Foundation
import UIKit

final class NewsFactory {

    static func buildNewsModule(article: Article) -> UIViewController {
        let vc = NewsViewController()
        let presenter = NewsPresenter(article: article)
        vc.presenter = presenter
        presenter.view = vc
        return vc
    }

}
