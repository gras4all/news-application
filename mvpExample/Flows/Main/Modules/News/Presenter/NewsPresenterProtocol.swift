//
//  NewsViewOutConnection.swift
//  mvpExample
//
//  Created by Андрей Груненков on 15.08.2022.
//

import Foundation

protocol NewsPresenterProtocol: AnyObject {
    
    func getArticle() -> Article
    
}
