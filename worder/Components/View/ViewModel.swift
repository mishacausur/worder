//
//  ViewModel.swift
//  worder
//
//  Created by Misha Causur on 07.11.2022.
//

import Foundation

protocol ViewInput: AnyObject {}

protocol ViewOutput: Coordinated {}

class ViewModel: ViewOutput {
    
    var coordinator: Coordinatable?
}
