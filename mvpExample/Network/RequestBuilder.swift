//
//  RequestBuilder.swift
//  mvpExample
//
//  Created by Андрей Груненков on 23.08.2022.
//

import Foundation

final class RequestBuilder {
    
    private static let scheme = "https"
    private static let host = "newsapi.org"
    private static let hostPath = "https://newsapi.org"
    private static let path = "/v2/everything"
    private static let apiKey = "fe7700ec6bfd45eeb2a1f229b81f9bb5"
    
    private static let defaultHeaders = [
        "Content-Type" : "application/json",
        "Accept" : "application/vnd.github.v3+json"
    ]
    
    static func buildRequest(params: Encodable, method: HTTPMethod = .get) -> URLRequest? {
        guard let dictParams = try? params.asDictionary() else { return nil }
        switch method {
        case .get:
            var urlComponents = URLComponents()
            urlComponents.scheme = scheme
            urlComponents.host = host
            urlComponents.path = path
            var queryItems = dictParams.map { key, value in
                URLQueryItem(name: key, value: String(describing: value))
            }
            queryItems.append(URLQueryItem(name: "apiKey", value: apiKey))
            urlComponents.queryItems = queryItems
            guard let url = urlComponents.url else { return nil }
            var request = URLRequest(url: url)
            request.allHTTPHeaderFields = defaultHeaders
            return request
        default:
            break
        }
        return nil
    }
    
}
