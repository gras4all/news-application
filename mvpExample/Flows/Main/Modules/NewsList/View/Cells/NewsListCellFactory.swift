//
//  NewsListCellFactory.swift
//  mvpExample
//
//  Created by Андрей Груненков on 26.08.2022.
//

import UIKit

struct NewsListCellFactory {
    
    static func buildNewsCell(tableView: UITableView, article: Any) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewsListCell.self)) as? NewsListCell,
           let article = article as? Article {
            cell.titleLabel.text = article.title
            cell.descriptionLabel.text = article.description
            if let date = article.date {
                cell.dateLabel.text = DatesHelper.dateToString(from: date, pattern: "yyyy-MM-dd")
            }
            return cell
        }
        return UITableViewCell()
    }
    
}
