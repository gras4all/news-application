//
//  News.swift
//  mvpExample
//
//  Created by Андрей Груненков on 16.08.2022.
//

import Foundation

struct Article: Decodable {
    
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var date: Date?
    
    enum CodingKeys: String, CodingKey {
        case author
        case title
        case description
        case url
        case urlToImage
        case date = "publishedAt"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.author = try? container.decode(String.self, forKey: .author)
        self.title = try? container.decode(String.self, forKey: .title)
        self.description = try? container.decode(String.self, forKey: .description)
        self.url = try? container.decode(String.self, forKey: .url)
        self.urlToImage = try? container.decode(String.self, forKey: .urlToImage)
        if let dateString = try? container.decode(String.self, forKey: .date) {
            self.date = DatesHelper.parseDate(from: dateString,
                                              pattern: "yyyy-MM-dd'T'HH:mm:ssZ")
        }
    }
    
}
