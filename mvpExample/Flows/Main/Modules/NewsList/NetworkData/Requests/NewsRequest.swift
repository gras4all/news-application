//
//  NewsRequest.swift
//  mvpExample
//
//  Created by Андрей Груненков on 23.08.2022.
//

import Foundation
import UIKit

struct NewsRequest: Requestable {
    
    var method: HTTPMethod = .get
    
    var query: String
    var sortBy: SortKind
    
    enum CodingKeys: String, CodingKey {
        case query = "q"
        case sortBy
    }
    
    func encode(to encoder: Encoder) throws {
        var rootContainer = encoder.container(keyedBy: CodingKeys.self)
        try rootContainer.encode(query, forKey: .query)
        try rootContainer.encode(sortBy.rawValue, forKey: .sortBy)
    }
    
}
