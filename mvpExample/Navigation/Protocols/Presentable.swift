//
//  Presentable.swift
//  mvpExample
//
//  Created by Андрей Груненков on 15.08.2022.
//

import UIKit

protocol Presentable {
    var toPresent: UIViewController? { get }
}

extension UIViewController: Presentable {
    
    var toPresent: UIViewController? {
        return self
    }
    
    func showAlert(title: String, message: String? = nil) {
        /*UIAlertController.showAlert(title            : title,
                                    message          : message,
                                    inViewController : self,
                                    actionBlock      : nil)*/
    }
    
}
