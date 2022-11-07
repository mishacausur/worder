//
//  Array.swift
//  worder
//
//  Created by Misha Causur on 07.11.2022.
//

import UIKit.NSLayoutConstraint

extension Array: Layout where Element == NSLayoutConstraint {
    
    var constraints: [NSLayoutConstraint] { self }
}
