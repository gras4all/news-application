//
//  Requestable.swift
//  mvpExample
//
//  Created by Андрей Груненков on 23.08.2022.
//

import Foundation

protocol Requestable: Encodable {
    
    var method: HTTPMethod { get }
    
}
