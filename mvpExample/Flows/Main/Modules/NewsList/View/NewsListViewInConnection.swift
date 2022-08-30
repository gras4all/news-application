//
//  NewsListViewInConnection.swift
//  mvpExample
//
//  Created by Андрей Груненков on 15.08.2022.
//

import Foundation

protocol NewsListViewInConnection: AnyObject {
    
    func reloadTable()
    
    func showLoader()
    
    func showSort(kind: SortKind)
    
    func hideLoader()
    
}
