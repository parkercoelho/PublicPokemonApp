//
//  Coordinator.swift
//  Pokemon
//
//  Created by Parker Coelho on 11/5/22.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
