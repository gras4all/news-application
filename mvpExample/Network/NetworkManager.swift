//
//  NetworkManager.swift
//  mvpExample
//
//  Created by Андрей Груненков on 15.08.2022.
//

import Foundation

enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}
enum RequestError: Error {
    case unknownError
    case connectionError
    case authorizationError
    case parseError
    case invalidRequest
    case notFound
    case invalidResponse
    case serverError
    case serverUnavailable
}

final class NetworkManager: NetworkManagerProtocol {
    
    func executeRequest<T: Decodable>(request: Requestable, completion: @escaping (T?, Error?) -> Void) {
        
        guard let urlRequest = RequestBuilder.buildRequest(params: request, method: request.method) else {
            completion(nil, RequestError.invalidRequest)
            return
        }
        
        performRequest(request: urlRequest) { [weak self] data, response, error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.handleNetworkResponse(data: data, response: response, error: error, completion: completion)
            }
        }
        
    }
    
}

private extension NetworkManager {
    
    func performRequest(request: URLRequest,
                                completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: request, completionHandler: completion)
        dataTask.resume()
    }
    
    func handleNetworkResponse<T: Decodable>(data: Data?, response: URLResponse?, error: Error?, completion: @escaping (T?, Error?) -> Void) {
        if let error = error {
            print(error)
            completion(nil, RequestError.connectionError)
        } else if let data = data,
                  let response = response as? HTTPURLResponse {
            switch response.statusCode {
            case 200:
                do {
                    let parsedResult = try JSONDecoder().decode(T.self, from: data)
                    completion(parsedResult, nil)
                }
                catch let parseJSONError {
                    completion(nil, RequestError.parseError)
                    print("error on parsing request to JSON : \(parseJSONError)")
                }
            case 400...499:
                completion(nil, RequestError.authorizationError)
            case 500...599:
                completion(nil, RequestError.serverError)
            default:
                completion(nil, RequestError.unknownError)
                break
            }
        } else {
            completion(nil, RequestError.unknownError)
        }
    }
    
}
