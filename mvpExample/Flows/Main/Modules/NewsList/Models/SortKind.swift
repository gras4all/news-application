//
//  SortKind.swift
//  mvpExample
//
//  Created by Андрей Груненков on 26.08.2022.
//

import UIKit

enum SortKind: String {
    
    case popular = "popularity"
    case date = "date"
    
    func getImage() -> UIImage? {
        switch self {
        case .popular:
            return UIImage(systemName: "person")
        case .date:
            return UIImage(systemName: "calendar")
        }
    }
}
