//
//  Coordinatable.swift
//  worder
//
//  Created by Misha Causur on 07.11.2022.
//

import UIKit.UINavigationController

protocol Coordinatable {
    
    var navigationController: UINavigationController { get set }
    func start()
    func route(_ destination: Route)
}
