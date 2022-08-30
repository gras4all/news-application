//
//  NetworkManagerProtocol.swift
//  mvpExample
//
//  Created by Андрей Груненков on 22.08.2022.
//

import Foundation

protocol NetworkManagerProtocol {
    
    func executeRequest<T: Decodable>(request: Requestable, completion: @escaping (T?, Error?) -> Void)
    
}
