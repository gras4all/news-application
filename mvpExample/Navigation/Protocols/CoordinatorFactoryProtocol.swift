//
//  CoordinatorFactoryProtocol.swift
//  mvpExample
//
//  Created by Андрей Груненков on 16.08.2022.
//

import UIKit

protocol CoordinatorFactoryProtocol {
    func makeMainCoordinator(router: Routable) -> Coordinatable & MainCoordinatorOutput
}
