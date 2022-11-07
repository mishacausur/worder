//
//  NSLayoutConstraint.swift
//  worder
//
//  Created by Misha Causur on 07.11.2022.
//

import UIKit.NSLayoutConstraint

// MARK: - Layout
extension NSLayoutConstraint: Layout {
    
    var constraints: [NSLayoutConstraint] { [self] }
}

// MARK: - Activate closure

extension NSLayoutConstraint {

    static func activate(@ConstraintBuilder constraints: () -> [NSLayoutConstraint]) {
        activate(constraints())
    }
}
