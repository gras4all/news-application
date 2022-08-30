//
//  NewsResponse.swift
//  mvpExample
//
//  Created by Андрей Груненков on 24.08.2022.
//

import Foundation

struct NewsResponse: Decodable {
    
    var articles: [Article]
    
    enum CodingKeys: String, CodingKey {
        case articles
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.articles = try container.decode([Article].self, forKey: .articles)
    }
    
}
