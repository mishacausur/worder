//
//  Builder.swift
//  worder
//
//  Created by Misha Causur on 07.11.2022.
//

import UIKit.NSLayoutConstraint

@resultBuilder
struct ConstraintBuilder {
    
    static func buildBlock(_ components: Layout...) -> [NSLayoutConstraint] {
        components.flatMap { $0.constraints }
    }
}
