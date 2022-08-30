//
//  NewsListPresenterProtocol.swift
//  mvpExample
//
//  Created by Андрей Груненков on 15.08.2022.
//

import UIKit

protocol NewsListPresenterProtocol: AnyObject {
    
    func selectNews(index: Int)
    
    func requestNews(query: String, withDelay: Bool)
    
    func requestNews()
    
    func sortSelected(kind: SortKind)
    
    func getNewsCount() -> Int
    
    func getCell(tableView: UITableView, index: Int) -> UITableViewCell
    
}
