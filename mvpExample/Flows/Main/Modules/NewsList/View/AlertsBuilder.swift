//
//  AlertsBuilder.swift
//  mvpExample
//
//  Created by Андрей Груненков on 29.08.2022.
//

import Foundation
import UIKit

struct AlertsBuilder {
    
    static func buildSortActionsMenu(menuItems: [UIAlertAction]) -> UIAlertController {
        let alertController = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
        alertController.modalPresentationStyle = .pageSheet
        for item in menuItems {
            alertController.addAction(item)
        }
        return alertController
    }
    
}
